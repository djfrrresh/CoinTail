//
//  HomeOperationHeader.swift
//  CoinTail
//
//  Created by Eugene on 14.06.23.
//

import UIKit
import EasyPeasy


final class HomeOperationHeader: UICollectionReusableView {
    
    static let id = "HomeOperationHeader"

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        return formatter
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.numberOfLines = 1
        
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
                
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
