//
//  BudgetCVHeader.swift
//  CoinTail
//
//  Created by Eugene on 06.07.23.
//

import UIKit
import EasyPeasy


final class BudgetCVHeader: UICollectionReusableView {
    
    static let id = "BudgetCVHeader"
    
    let separatorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.numberOfLines = 1
        
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(separatorLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        separatorLabel.easy.layout([
            Bottom(8),
            Left(16)
        ])
    }
    
    func separator(isVisible: Bool) {
        separatorLabel.isHidden = !isVisible
    }
    
}
