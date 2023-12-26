//
//  PremiumPlansHeader.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import UIKit
import EasyPeasy


final class PremiumPlansHeader: UICollectionReusableView {
    
    static let id = "PremiumPlansHeader"
    
    let ratesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.numberOfLines = 1
        label.text = "Available rates".localized()
        
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
        
        addSubview(ratesLabel)

        ratesLabel.easy.layout([
            Bottom(8),
            Left(16)
        ])
    }
    
}
