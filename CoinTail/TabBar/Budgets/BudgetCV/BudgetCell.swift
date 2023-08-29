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
    var backImage: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    let budgetProgress: UIProgressView = {
        let progress = UIProgressView()
        progress.setProgress(0, animated: true)
        progress.trackTintColor = .systemGray2
        return progress
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        return label
    }()
    
    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
                
        addSubview(backView)
        
        backView.addSubview(backImage)
        backView.addSubview(budgetProgress)
        backView.addSubview(amountLabel)
        backView.addSubview(categoryLabel)
        
        backImage.addSubview(categoryImage)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout(Edges())
        
        backImage.easy.layout([
            CenterY(),
            Left(8),
            Height(50),
            Width(50)
        ])
        
        categoryImage.easy.layout([
            Center(),
            Height(40),
            Width(40)
        ])
        
        amountLabel.easy.layout([
            Right(8),
            Top(8)
        ])
        
        categoryLabel.easy.layout([
            Left(8).to(backImage, .right),
            Top(8)
        ])
        
        budgetProgress.easy.layout([
            Height(12),
            Left(8).to(backImage, .right),
            Right(8),
            Bottom(8)
        ])
    }
    
    func calculateProgressView(sum: Double, total: Double) {
        let value = sum / total
        
        if value >= 0.75 {
            budgetProgress.tintColor = UIColor(named: "expense")
        } else if value >= 0.5 && value < 0.75 {
            budgetProgress.tintColor = UIColor(named: "budget")
        } else {
            budgetProgress.tintColor = UIColor(named: "income")
        }
        
        budgetProgress.setProgress(Float(value), animated: true)
    }
    
    func calculatePercent(sum: Double, total: Double) -> String {
        let stringPercent = (sum / total) * 100
        return String(format: "%.0f", stringPercent)
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 60
        )
    }
}
