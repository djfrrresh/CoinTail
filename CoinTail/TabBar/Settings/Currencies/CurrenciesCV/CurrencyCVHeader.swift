//
//  CurrencyCVHeader.swift
//  CoinTail
//
//  Created by Eugene on 13.09.23.
//

import UIKit
import EasyPeasy


final class CurrencyCVHeader: UICollectionReusableView {
    
    static let id = "CurrencyCVHeader"

    let favouretesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(favouretesLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        favouretesLabel.easy.layout([
            CenterY(),
            Left(16)
        ])
    }
    
}
