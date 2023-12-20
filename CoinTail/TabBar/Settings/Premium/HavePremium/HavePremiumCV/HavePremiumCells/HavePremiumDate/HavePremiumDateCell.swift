//
//  HavePremiumDateCell.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit
import EasyPeasy


final class HavePremiumDateCell: UICollectionViewCell {
    
    static let id = "HavePremiumDateCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.numberOfLines = 1
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(dateLabel)

        dateLabel.easy.layout([
            Bottom(8),
            Left(16),
            Right()
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16,
            height: 20
        )
    }
    
}
