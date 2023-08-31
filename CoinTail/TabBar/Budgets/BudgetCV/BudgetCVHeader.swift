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

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let separatorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(dateLabel)
        addSubview(separatorLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.easy.layout([
            CenterY(),
            Left()
        ])
        
        separatorLabel.easy.layout([
            CenterY(),
            Right()
        ])
    }
    
    func separator(isVisible: Bool) {
        separatorLabel.isHidden = !isVisible
    }
    
}
