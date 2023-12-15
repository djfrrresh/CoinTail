//
//  PaymentFacade.swift
//  CoinTail
//
//  Created by Eugene on 16.12.23.
//

import RevenueCat


final class PaymentFacade {
    
    static let shared = PaymentFacade()

    func getPlanCellData(completion: @escaping ([PlanData]?) -> ()) {
//        switch AppSettings.shared.premiumDisplay {
//        case .revenueCat:
            RevenueCatService.shared.getOfferings { data in
                completion(data)
            }
//        default:
//            completion(nil)
//        }
    }

    func payPremium(plan: Package?, completion: @escaping (CustomerInfo?, Date?) -> ()) {
        guard let package = plan else {
            completion(nil,nil)
            return
        }
        
        RevenueCatService.shared.purchase(package: package) { customerInfo, date in
            completion(customerInfo, date)
        }
    }
    
    func getCustomerInfo(completion: @escaping (CustomerInfo?, Date?) -> ()) {
        RevenueCatService.shared.getCustomerInfo(completion: { customerInfo, date in
            completion(customerInfo, date)
        })
    }
    
    
    func restorePurchases(completion: @escaping (RestoreResponse)->()) {
        RevenueCatService.shared.restorePurchases { resp in
            completion(resp)
        }
    }
}
