//
//  RevenueCatService.swift
//  CoinTail
//
//  Created by Eugene on 14.12.23.
//

import RevenueCat


enum RestoreResponse {
    case success(Date)
    case noSubs, noData
}

final class RevenueCatService {
    
    static let shared = RevenueCatService()
    
    func getOfferings(completion: @escaping ([PlanData]?) -> ()) {
        Purchases.shared.getOfferings { (offerings, error) in
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
    func restorePurchases(completion: @escaping (RestoreResponse) -> ()) {
        Purchases.shared.restorePurchases { customerInfo, error in
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
    
    func getCustomerInfo(completion: @escaping (CustomerInfo?, Date?) -> ()) {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
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
    
    func purchase(package: Package, completion: @escaping (CustomerInfo?, Date?) -> ()) {
        Purchases.shared.purchase(package: package) { (transaction, customerInfo, error, userCancelled) in
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
