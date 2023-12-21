//
//  PaymentFacade.swift
//  CoinTail
//
//  Created by Eugene on 16.12.23.
//

import RevenueCat


final class PaymentFacade {
    
    static let shared = PaymentFacade()

    func getPlanCellData(completion: @escaping ([PlanData]?) -> Void) {
        RevenueCatService.shared.getOfferings { data in
            completion(data)
        }
    }

    func payPremium(plan: Package?, completion: @escaping (CustomerInfo?, Date?) -> Void) {
        guard let package = plan else {
            completion(nil,nil)
            return
        }
        
        RevenueCatService.shared.purchase(package: package) { customerInfo, date in
            completion(customerInfo, date)
        }
    }
    
    func getCustomerInfo(completion: @escaping (CustomerInfo?, Date?) -> Void) {
        RevenueCatService.shared.getCustomerInfo(completion: { customerInfo, date in
            completion(customerInfo, date)
        })
    }
    
    
    func restorePurchases(completion: @escaping (RestoreResponse) -> Void) {
        RevenueCatService.shared.restorePurchases { resp in
            completion(resp)
        }
    }
}
