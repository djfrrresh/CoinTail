//
//  BudgetCell.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
//

import UIKit
import EasyPeasy


final class BudgetCell: UICollectionViewCell {
    
    static let id = "BudgetCell"
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    let budgetProgressView: UIProgressView = {
        let progress = UIProgressView()
        progress.setProgress(0.5, animated: true)
        progress.trackTintColor = .systemGray2
        progress.tintColor = UIColor(named: "income")
        return progress
    }()
    
    let budgetName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    
    let budgetAmount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
                
        addSubview(backView)
        backView.addSubview(budgetProgressView)
        backView.addSubview(budgetAmount)
        backView.addSubview(budgetName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout(Edges())
        
        budgetAmount.easy.layout([
            Right(8),
            Top(8)
        ])
        
        budgetName.easy.layout([
            Left(8),
            Top(8)
        ])
        
        budgetProgressView.easy.layout([
            Height(12),
            Left(8),
            Right(8),
            Bottom(8)
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 60
        )
    }
}
