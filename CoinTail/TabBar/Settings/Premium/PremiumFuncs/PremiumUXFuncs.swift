//
//  PremiumUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import UIKit


extension PremiumVC {
    
    func premiumTargets() {
        navBarButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    func getPlan() {
        if let trialPlan = plans.first(where: { plan in
            plan.isTrial
        }) {
            self.plan = trialPlan
        } else {
            self.plan = plans[0]
        }
    }
    
    func revenueCatPayment() {
        PaymentFacade.shared.payPremium(plan: plan.package) { [weak self] (_, date) in
            guard let strongSelf = self else {
                DispatchQueue.main.async {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
                self?.buyPremiumButton.waitingState(false)
                self?.view.isUserInteractionEnabled = true
                
                return
            }

            if let date = date {
                self?.dismiss(animated: false) {
                    let vc = HavePremiumVC(AdvantagesData.advantages, expirationDate: date)
                    vc.modalPresentationStyle = .fullScreen
                    
                    strongSelf.present(vc, animated: true)
                }
            } else {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }

            strongSelf.buyPremiumButton.waitingState(false)
            strongSelf.view.isUserInteractionEnabled = true
        }
    }
    
}
