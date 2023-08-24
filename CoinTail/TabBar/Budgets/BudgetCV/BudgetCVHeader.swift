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
        formatter.locale = Locale(identifier: "en_EN")
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        return label
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
            CenterY(),
            Left()
        ])
    }
    
}
