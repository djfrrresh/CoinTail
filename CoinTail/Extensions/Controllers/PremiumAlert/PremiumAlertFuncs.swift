//
//  PremiumAlertFuncs.swift
//  CoinTail
//
//  Created by Eugene on 21.12.23.
//

import UIKit
import EasyPeasy


extension PremiumAlert {
    
    static func getDescriptionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }
    
    func alertActions() {
        dismissButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)
        buyPremiumButton.addTarget(self, action: #selector(goToPremiumVC), for: .touchUpInside)
    }
    
    func alertSubviews() {
        let imageViewHeight: CGFloat = 200
        let buyButtonHeight: CGFloat = 52
        let backViewWidth: CGFloat = UIScreen.main.bounds.width - (16 * 2)
        let textWidth: CGFloat = backViewWidth - (16 * 2)
        let titleHeight: CGFloat = 24
        
        let descriptionHeight: CGFloat = descriptionLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let backViewHeight = imageViewHeight + (24 * 2) + titleHeight + 8 + descriptionHeight + 24 + buyButtonHeight + 16
        
        self.view.addSubview(overlayView)
        self.view.addSubview(backView)
        
        backView.addSubview(buyPremiumButton)
        backView.addSubview(dismissButton)
        backView.addSubview(titleLabel)
        backView.addSubview(descriptionLabel)
        backView.addSubview(crownImageView)

        backView.easy.layout([
            Height(backViewHeight),
            Left(16),
            Right(16),
            Center()
        ])
        
        buyPremiumButton.easy.layout([
            Height(52),
            Left(16),
            Right(16),
            Bottom(16)
        ])
        
        crownImageView.easy.layout([
            Height(200),
            Width(200),
            Top(24),
            CenterX()
        ])
        
        dismissButton.easy.layout([
            Right(16),
            Top(16),
            Width(24),
            Height(24)
        ])
        
        titleLabel.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(crownImageView, .bottom)
        ])
        
        descriptionLabel.easy.layout([
            Left(16),
            Right(16),
            Top(8).to(titleLabel, .bottom)
        ])
    }
    
    @objc func dismissButtonAction(_ button: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.alpha = 0
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func goToPremiumVC(_ button: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.alpha = 0
        }) { _ in
            let vc = PremiumVC(PremiumPlans.shared.plans)
            vc.modalPresentationStyle = .fullScreen

            self.dismiss(animated: true) {
                guard let topController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController else { return }
                
                topController.present(vc, animated: true)
            }
        }
    }
    
}
