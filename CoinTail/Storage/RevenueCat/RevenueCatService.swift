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
    
    func getOfferings(completion: @escaping ([PlanData]?) -> Void) {
        Purchases.shared.getOfferings { (offerings, _) in
            var plan = [PlanData]()
            
            guard let packages = offerings?.current?.availablePackages else {
                completion(nil)
                return
            }
            
            for package in packages {
                guard let period = package.storeProduct.subscriptionPeriod else { return }
                
                let price = package.storeProduct.localizedPriceString
                
                let titlePackage: String = period.localized
                let planPeriod = (period.unit == .year ? "year".localized() : "month".localized())
                let descriptionPackage = "\(price)" + "/" + planPeriod
                
                var data = PlanData(
                    title: titlePackage,
                    price: Int(price) ?? 0,
                    buyButtonTitle: "\(price)",
                    period: planPeriod,
                    description: descriptionPackage,
                    package: package
                )
                
                if let introductoryDiscount = package.storeProduct.introductoryDiscount {
                    if let offer = introductoryDiscount.sk1Discount,
                       introductoryDiscount.paymentMode == .freeTrial {
                        data.promoText = "\(offer.subscriptionPeriod.numberOfUnits)" + "free days".localized()
                        
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
                        data.promoText =  "\(offer.period.value)" + "free days".localized()

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
//                        NetworkManager.shared.premiumReport(customerInfo)
                        
                        completion(.success(expirationDate))
                    }
                } else {
                    completion(.noSubs)
                }
            } else {
                completion(.noData)
            }
        }
    }
    
    func getCustomerInfo(completion: @escaping (CustomerInfo?, Date?) -> Void) {
        Purchases.shared.getCustomerInfo { (customerInfo, _) in
            guard let customerInfo = customerInfo else {
                completion(nil, nil)
                return
            }
            
            var expDate: Date?
            
            if let entitlement = customerInfo.entitlements.active.first?.value,
               let expirationDate = customerInfo.expirationDate(forProductIdentifier: entitlement.productIdentifier),
               expirationDate.timeIntervalSince1970 > Date().timeIntervalSince1970 {
                expDate = expirationDate
            }
            //TODO: premium
//            else if let expirationDateUnix = AppSettings.shared.premium?.premiumActiveUntil,
//                      Date(timeIntervalSince1970: TimeInterval(expirationDateUnix)) > Date() {
//                expDate = Date(timeIntervalSince1970: TimeInterval(expirationDateUnix))
//            }
            
            guard let expDate = expDate else {
                completion(customerInfo, nil)
                return
            }
            
            completion(customerInfo ,expDate)
        }
    }
    
    func purchase(package: Package, completion: @escaping (CustomerInfo?, Date?) -> Void) {
        Purchases.shared.purchase(package: package) { (_, customerInfo, _, _) in
            guard let customerInfo = customerInfo else {
                completion(nil, nil)
                return
            }
            
            var expDate: Date?
            
            if let entitlement = customerInfo.entitlements.active.first?.value,
               let expirationDate = customerInfo.expirationDate(forProductIdentifier: entitlement.productIdentifier),
               expirationDate.timeIntervalSince1970 > Date().timeIntervalSince1970 {
                expDate = expirationDate
//                NetworkManager.shared.premiumReport(customerInfo)
            }
            //TODO: premium
//            else if let expirationDateUnix = AppSettings.shared.premium?.premiumActiveUntil,
//                      Date(timeIntervalSince1970: TimeInterval(expirationDateUnix)) > Date() {
//                expDate = Date(timeIntervalSince1970: TimeInterval(expirationDateUnix))
//            }
            
            guard let expDate = expDate else {
                completion(customerInfo, nil)
                return
            }
            
            completion(customerInfo, expDate)
        }
    }
}
