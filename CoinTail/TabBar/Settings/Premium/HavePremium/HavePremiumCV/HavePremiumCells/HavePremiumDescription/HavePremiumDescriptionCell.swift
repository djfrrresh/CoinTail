//
//  HavePremiumDescriptionCell.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit
import EasyPeasy


final class HavePremiumDescriptionCell: UICollectionViewCell {
    
    static let id = "HavePremiumDescriptionCell"

    let descriptionLabel: UILabel = getDescriptionLabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.easy.layout([
            Edges()
        ])
    }
    
    static func getDescriptionLabel() -> UILabel {
        let l = UILabel()
        l.textColor = .textSecondary
        l.numberOfLines = 0
        l.font = Fonts.SFProText.regular(12)
        l.textAlignment = .left
        
        return l
    }
    
    static func size(_ descriptionText: String?) -> CGSize {
        guard let descriptionText = descriptionText else {
            return .init(
                width: 0,
                height: 0
            )
        }
        let textWidth =  UIScreen.main.bounds.width - 20 * 2
        let description = getDescriptionLabel()
        description.text = descriptionText
        let descriptionSize = description.sizeThatFits(.init(width: textWidth, height: 0))
        let textHeight = descriptionSize.height
        return .init(
            width: UIScreen.main.bounds.width - 20 * 2,
            height: textHeight
        )
    }
    
}
