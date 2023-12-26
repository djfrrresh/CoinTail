//
//  TransfersHistoryCVHeader.swift
//  CoinTail
//
//  Created by Eugene on 25.10.23.
//

import UIKit
import EasyPeasy


final class TransfersHistoryCVHeader: UICollectionReusableView {
    
    static let id = "TransfersHistoryCVHeader"

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    let headerDF: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        return formatter
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(dateLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.easy.layout([
            Bottom(8),
            Left(16)
        ])
    }
    
}
