//
//  PremiumPrivacyCell.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import UIKit
import EasyPeasy


protocol PremiumPrivacyDelegate: AnyObject {
    func restorePurchaseButtonTap()
    func showLegalDocuments(link: String)
}

final class PremiumPrivacyCell: UICollectionViewCell {
    
    static let id = "PremiumPrivacyCell"

    weak var privacyDelegate: PremiumPrivacyDelegate?
//    private var ranges = [PrivacyLink: NSRange]()
    
    let descriptionLabel: UILabel = getDescriptionLabel()
    
    let restorePurchaseButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.setTitle("Restore purchase".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "primaryAction"), for: .normal)
        button.addTarget(nil, action: #selector(tapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(restorePurchaseButton)

        descriptionLabel.easy.layout(
            Top(),
            Left(),
            Right()
        )
                
        restorePurchaseButton.easy.layout(
            Bottom(),
            CenterX()
        )
    }
    
    func setupDescriptionLabelText(_ data: PlanData) {
//        ranges.removeAll()
        
        var description: String!
        
        if let trialDays = data.trialDaysInt {
            let dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                
                return dateFormatter
            }()
            
            let expirationDate = Date().advanced(by: 86400 * Double(trialDays))
            let dateString = dateFormatter.string(from: expirationDate)
            
            let descriptionFormat = NSLocalizedString("After %@, you will be charged, your subscription will auto-renew for the full price and package until you cancel via App Store settings, and you agree to our Terms and Privacy Policy.".localized(), comment: "")

            description = String.localizedStringWithFormat(descriptionFormat, dateString)
        } else {
            description = "By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our Terms and Privacy Policy.".localized()
        }
                
//        let attributedString = NSMutableAttributedString(
//            string: description,
//            attributes: [
//                NSAttributedString.Key.font: descriptionLabel.font!,
//                NSAttributedString.Key.kern: -0.17]
//        )
        
//        for privacy in privacys.payWallLinks {
//            let localizedText: String = .localized(privacy.localizationKey)
//            if description.contains(localizedText) {
//                let range = NSRange(location: description.index(of: localizedText)!.utf16Offset(in: description), length: localizedText.contains(".") ? localizedText.count - 1 :  localizedText.count)
//
//                attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
//                                              value: NSUnderlineStyle.single.rawValue,
//                                              range: range)
//                descriptionLabel.attributedText = attributedString
//                ranges[privacy] = range
//            } else {
                descriptionLabel.text = description
//            }
//        }
        
        self.descriptionLabel.isUserInteractionEnabled = true
        
        let descriptionTap = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        descriptionTap.numberOfTapsRequired = 1
        
        self.descriptionLabel.addGestureRecognizer(descriptionTap)
    }
    
    @objc func tapped() {
//        delegate?.restorePurchaseButtonTap()
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
//        guard let privacys = AppSettings.shared.privacy else { return }
//
//        for privacy in privacys.payWallLinks {
//            guard let range = ranges[privacy] else { return }
//            if gesture.didTapAttributedTextInLabel(label: self.descriptionLabel, inRange: range) {
//                delegate?.showLegalDocuments(link: privacy.url)
//            }
//        }
    }
    
    static func getDescriptionLabel() -> UILabel {
        let label = UILabel(frame: .init(x: 0, y: 0,
                                     width: UIScreen.main.bounds.width - 16 * 2,
                                     height: 0))
        label.textColor = UIColor(named: "secondaryTextColor")
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textAlignment = .left
        label.sizeToFit()
        
        return label
    }
    
    //TODO: с локализацией не работает динамическая высота
    static func size(_ plans: [PlanData]) -> CGSize {
        let textWidth =  UIScreen.main.bounds.width - 16 * 2
        let description = getDescriptionLabel()
        
        if let trialPlan = plans.first(where: { plan in
            plan.isTrial
        }), let trialDays = trialPlan.trialDaysInt {
            let dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                
                return dateFormatter
            }()
            
            description.text = "After \(dateFormatter.string(from: Date().advanced(by: TimeInterval(86400 * trialDays)))), you will be charged, your subscription will auto-renew for the full price and package until you cancel via App Store settings, and you agree to our Terms and Privacy Policy.".localized()
        } else {
            description.text = "By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our Terms and Privacy Policy.".localized()
        }
        
        let descriptionSize = description.sizeThatFits(.init(width: textWidth, height: 0))
        let textHeight = descriptionSize.height + 22 + 20
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: textHeight
        )
    }
    
}
