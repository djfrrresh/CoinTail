//
//  PremiumUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
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
//        PaymentFacade.shared.payPremium(plan: plan.package) { [weak self] (_, date) in
//            guard let strongSelf = self else {
//                DispatchQueue.main.async {
//                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
//                }
//                self?.buyPremiumButton.waitingState(false)
//                self?.view.isUserInteractionEnabled = true
//
//                return
//            }
//
//            //TODO: не приходит date из за plan.package
//            if let date = date {
        // возможно будет работать без dismiss
//                self?.dismiss(animated: false) {
//                    guard var topController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController else { return }
//
//                    let vc = HavePremiumVC(AdvantagesData.advantages, expirationDate: date)
//                    vc.modalPresentationStyle = .fullScreen
//
//                    topController.present(vc, animated: true)
//                }
//            } else {
//                UIImpactFeedbackGenerator(style: .light).impactOccurred()
//            }
        // удалить dismiss
        let date = Date()
        let vc = HavePremiumVC(AdvantagesData.advantages, expirationDate: date)
        vc.modalPresentationStyle = .fullScreen
        guard let topController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController else { return }
        
        topController.present(vc, animated: true)
            
//            strongSelf.buyPremiumButton.waitingState(false)
//            strongSelf.view.isUserInteractionEnabled = true
//        }
    }
    
}
