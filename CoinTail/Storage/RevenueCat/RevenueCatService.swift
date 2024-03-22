//
//  RevenueCatService.swift
//  CoinTail
//
//  Created by Eugene on 14.12.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import RevenueCat


enum RestoreResponse {
    case success(Date)
    case noSubs, noData
}

final class RevenueCatService {
    
    static let shared = RevenueCatService()
    
    private init() {
        // Регистрируем уникальный айди для каждого пользователя
        let udid = KeychainManager.shared.getUDID()
        #if DEBUG
        Purchases.logLevel = .warn
        #else
        Purchases.logLevel = .info
        #endif
        Purchases.configure(
            with: Configuration.Builder(withAPIKey: "API_KEY")
                .with(appUserID: udid)
                .build()
        )
        Purchases.shared.getOfferings { _, _ in }
    }
    
    // Получение подписок с RevenueCat, создание модели подписок
    func getOfferings(completion: @escaping ([PlanData]?) -> Void) {
        Purchases.shared.getOfferings { (offerings, _) in
            var plan = [PlanData]()
            
            guard let packages = offerings?.current?.availablePackages else {
                SentryManager.shared.capture(error: "No available packages", level: .error)
                completion(nil)
                
                return
            }
            
            for package in packages {
                guard let period = package.storeProduct.subscriptionPeriod else {
                    SentryManager.shared.capture(error: "No subscription periods", level: .error)
                    
                    return
                }
                
                let titlePackage: String
                switch period.localized {
                case "1month":
                    titlePackage = "Month".localized()
                case "1year":
                    titlePackage = "Year".localized()
                default:
                    titlePackage = "Period"
                }
                
                let price = package.storeProduct.localizedPriceString
                let planPeriod = (period.unit == .year ? "year".localized() : "month".localized())
                let descriptionPackage = price + "/" + planPeriod
                
                var data = PlanData(
                    title: titlePackage,
                    price: price,
                    buyButtonTitle: "Continue - total ".localized() + price,
                    period: planPeriod,
                    description: descriptionPackage,
                    package: package
                )
                data.isTrial = false
                data.privacyText = "By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our User Agreement and Privacy Policy.".localized()
                
                if let introductoryDiscount = package.storeProduct.introductoryDiscount {
                    if let offer = introductoryDiscount.sk1Discount,
                       introductoryDiscount.paymentMode == .freeTrial {
                        data.promoText = "\(offer.subscriptionPeriod.numberOfUnits) " + "free days".localized()
                        
                        switch offer.subscriptionPeriod.unit {
                        case .day:
                            data.trialDaysInt = offer.numberOfPeriods
                        case .week:
                            data.trialDaysInt = offer.numberOfPeriods * 7
                        case .month:
                            data.trialDaysInt = offer.numberOfPeriods * 30
                        case .year:
                            data.trialDaysInt = offer.numberOfPeriods * 365
                        @unknown default:
                            break
                        }
                    } else if #available(iOS 15.0, *),
                                let offer = introductoryDiscount.sk2Discount,
                              introductoryDiscount.paymentMode == .freeTrial {
                        data.promoText =  "\(offer.period.value) " + "free days".localized()

                        switch offer.period.unit {
                        case .day:
                            data.trialDaysInt = offer.periodCount
                        case .week:
                            data.trialDaysInt = offer.periodCount * 7
                        case .month:
                            data.trialDaysInt = offer.periodCount * 30
                        case .year:
                            data.trialDaysInt = offer.periodCount * 365
                        @unknown default:
                            break
                        }
                    }
                    
                    data.isTrial = true
                    data.privacyText = "After %@, you will be charged, your subscription will auto-renew for the full price and package until you cancel via App Store settings, and you agree to our User Agreement and Privacy Policy.".localized()
                }
                
                plan.append(data)
            }
            
            completion(plan)
        }
    }

    // Восстановить покупки
    func restorePurchases(completion: @escaping (RestoreResponse) -> Void) {
        Purchases.shared.restorePurchases { customerInfo, _ in
            if let customerInfo = customerInfo {
                if customerInfo.activeSubscriptions.count > 0 {
                    if let expirationDate = customerInfo.expirationDate(forProductIdentifier: customerInfo.activeSubscriptions.first!),
                       expirationDate.timeIntervalSince1970 > Date().timeIntervalSince1970 {
                        completion(.success(expirationDate))
                    }
                } else {
                    SentryManager.shared.capture(error: "No subscription to restore", level: .info)
                    
                    completion(.noSubs)
                }
            } else {
                SentryManager.shared.capture(error: "No subscription data", level: .info)
                
                completion(.noData)
            }
        }
    }
    
    // Функция оплаты подписки
    func purchase(package: Package, completion: @escaping (CustomerInfo?, Date?) -> Void) {
        Purchases.shared.purchase(package: package) { (_, customerInfo, error, _) in
            guard let customerInfo = customerInfo else {
                SentryManager.shared.capture(error: "No customer info", level: .error)
                completion(nil, nil)
                
                return
            }
            
            if let error = error {
                print(error.localizedDescription)
            }
                        
            var expDate: Date?
            
            // Получаем информацию об активных привелегиях и id продукта
            if let entitlement = customerInfo.entitlements.active.first?.value,
               let expirationDate = customerInfo.expirationDate(forProductIdentifier: entitlement.productIdentifier),
               expirationDate.timeIntervalSince1970 > Date().timeIntervalSince1970 {
                expDate = expirationDate
            }
            
            guard let expDate = expDate else {
                SentryManager.shared.capture(error: "No expiration date", level: .error)
                completion(customerInfo, nil)
                
                return
            }
            
            let premiumStatus = PremiumStatusClass()
            premiumStatus.isPremiumActive = true
            premiumStatus.premiumActiveUntil = Int64(expDate.timeIntervalSince1970)
            
            AppSettings.shared.premiumStatus = premiumStatus
                        
            completion(customerInfo, expDate)
        }
    }
    
}
