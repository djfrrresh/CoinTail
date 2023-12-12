//
//  PremiumDescriptionCell.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit
import EasyPeasy


final class PremiumDescriptionCell: UICollectionViewCell {
    
    static let id = "PremiumDescriptionCell"
    
    let descriptionLabel: UILabel = getDescriptionLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.backgroundColor = .clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(descriptionLabel)
        
        contentView.easy.layout([
            Edges()
        ])
        
        descriptionLabel.easy.layout([
            Left(),
            Right(),
            Bottom()
        ])
    }
    
    static func getDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Try it for free to get access to all the features".localized()

        return label
    }
    
    static func size() -> CGSize {
        let textWidth =  UIScreen.main.bounds.width - 16 * 2

        let descriptionLabel = getDescriptionLabel()
        let descriptionSize = descriptionLabel.sizeThatFits(.init(width: textWidth, height: 0))
        
        let textHeight = descriptionSize.height + 16
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: textHeight
        )
    }
    
}
