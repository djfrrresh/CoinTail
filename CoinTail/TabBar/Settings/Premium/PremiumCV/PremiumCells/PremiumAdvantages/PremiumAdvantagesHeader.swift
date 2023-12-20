//
//  PremiumAdvantagesHeader.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit
import EasyPeasy


final class PremiumAdvantagesHeader: UICollectionReusableView {
    
    static let id = "PremiumAdvantagesHeader"
    
    let accessLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.numberOfLines = 1
        label.text = "Now you have access to".localized()
        
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(accessLabel)

        accessLabel.easy.layout([
            Bottom(8),
            Left(16)
        ])
    }
    
}
