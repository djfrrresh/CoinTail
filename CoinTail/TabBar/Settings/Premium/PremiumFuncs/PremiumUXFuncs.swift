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
    
    @objc func tapped() {
        buyPremiumButton.waitingState(true)
        self.view.isUserInteractionEnabled = false
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
//        switch premiumDisplay {
//        case .none: break
//        case .revenueCat:
//            revenueCatPayment()
//        case .tcs:
//            guard let plan = plan.tcsPlan else { return }
//            tcsPayment(plan)
//        }
    }
    
//    private func tcsPayment(_ plan: TCSPlan) {
//        let vc = TCSVC(plan: plan, dismissHandler: dismissHandler)
//        vc.modalPresentationStyle = .fullScreen
//        navigationController?.pushVC(vc, animated: true)
//
//        buyButton.waitingState(false)
//        view.isUserInteractionEnabled = true
//    }
//
//    private func revenueCatPayment() {
//        PaymentFacade.shared.payPremium(plan: plan.package) { [weak self] (_, date) in
//            guard let strongSelf = self else {
//                Async.main {
//                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
//                }
//                self?.buyButton.waitingState(false)
//                self?.view.isUserInteractionEnabled = true
//                return
//            }
//
//            if let date = date {
//                self?.dismiss(animated: false) {
//                    let vc = YouSubscribedVC(AdvantagesCellData.advantages, expirationDate: date)
//                    vc.modalPresentationStyle = .fullScreen
//                    topController().present(vc, animated: true)
//                }
//            } else {
//                UIImpactFeedbackGenerator(style: .light).impactOccurred()
//            }
//
//            strongSelf.buyButton.waitingState(false)
//            strongSelf.view.isUserInteractionEnabled = true
//        }
//    }
    
}
