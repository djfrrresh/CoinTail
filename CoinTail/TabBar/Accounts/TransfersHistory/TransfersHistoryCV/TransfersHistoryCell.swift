//
//  TransfersHistoryCell.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit
import EasyPeasy


final class TransfersHistoryCell: UICollectionViewCell {
    
    static let id = "TransfersHistoryCell"
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        return view
    }()
    let sourceSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    let targetSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "arrow.right")
        
        return imageView
    }()

    let sourceAccountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let targetAccountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()
    let sourceAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "sourceAccount")
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textAlignment = .center
        
        return label
    }()
    let targetAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "targetAccount")
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
                
        addSubview(backView)
        
        backView.addSubview(arrowImageView)
        backView.addSubview(sourceSeparatorView)
        backView.addSubview(targetSeparatorView)
        backView.addSubview(sourceAccountLabel)
        backView.addSubview(targetAccountLabel)
        backView.addSubview(sourceAmountLabel)
        backView.addSubview(targetAmountLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Edges()
        ])
        
        arrowImageView.easy.layout([
            Center(),
            Height(20),
            Width(20)
        ])
        
        sourceAccountLabel.easy.layout([
            Left(16),
            Top(16),
            Right(16).to(arrowImageView, .left)
        ])
        targetAccountLabel.easy.layout([
            Right(16),
            Top(16),
            Left(16).to(arrowImageView, .right)
        ])
        
        sourceSeparatorView.easy.layout([
            Top(8).to(sourceAccountLabel, .bottom),
            Left(16),
            Right(16).to(arrowImageView, .left),
            Height(0.5)
        ])
        targetSeparatorView.easy.layout([
            Top(8).to(sourceAccountLabel, .bottom),
            Right(16),
            Left(16).to(arrowImageView, .right),
            Height(0.5)
        ])
        
        sourceAmountLabel.easy.layout([
            Left(16),
            Top(8).to(sourceSeparatorView, .top),
            Right(16).to(arrowImageView, .left)
        ])
        targetAmountLabel.easy.layout([
            Right(16),
            Top(8).to(targetSeparatorView, .top),
            Left(16).to(arrowImageView, .right)
        ])
    }
    
    static func getSourceAccountNameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    static func getTargetAccountNameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    static func getAccountAmountLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    static func size(data: TransferHistoryClass) -> CGSize {
        let amountLabel = getAccountAmountLabel()
        let sourceNameLabel = getSourceAccountNameLabel()
        let targetNameLabel = getTargetAccountNameLabel()
        
        amountLabel.text = "\(data.amount)"
        sourceNameLabel.text = data.sourceAccount
        targetNameLabel.text = data.targetAccount
        
        let amountWidth = amountLabel.sizeThatFits(CGSize.zero).width
        let sourceNameWidth = sourceNameLabel.sizeThatFits(CGSize.zero).width
        let targetNameWidth = targetNameLabel.sizeThatFits(CGSize.zero).width
        
        let padding: CGFloat = 16.0
        let middlePadding: CGFloat = 8.0
        
        let textWidth = (UIScreen.main.bounds.width - (2 * padding) - 20 - (2 * padding)) / 2
    
        let sourceHeight: CGFloat = sourceNameLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let targetHeight: CGFloat = targetNameLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let amountHeight: CGFloat = amountLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        
        let cellHeight = (sourceHeight > targetHeight ? sourceHeight : targetHeight) + (2 * padding) + (2 * middlePadding) + amountHeight
                        
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: cellHeight
        )
    }
    
}
