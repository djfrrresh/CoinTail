//
//  OperationHeader.swift
//  CoinTail
//
//  Created by Eugene on 14.06.23.
//

import UIKit
import EasyPeasy


final class OperationCVHeader: UICollectionReusableView {
    
    static let id = "OperationCVHeader"

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        return formatter
    }()
    
    let dateLabel: UILabel = {
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
