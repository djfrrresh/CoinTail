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
        label.textColor = UIColor(named: "expense")
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textAlignment = .center
        
        return label
    }()
    let targetAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "income")
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(arrowImageView)
        contentView.addSubview(sourceSeparatorView)
        contentView.addSubview(targetSeparatorView)
        contentView.addSubview(sourceAccountLabel)
        contentView.addSubview(targetAccountLabel)
        contentView.addSubview(sourceAmountLabel)
        contentView.addSubview(targetAmountLabel)
        
        contentView.easy.layout([
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
    
    static func getSourceAccountAmountLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    static func getTargetAccountAmountLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    static func size(data: TransferHistoryClass) -> CGSize {
        let sourceAmountLabel = getSourceAccountAmountLabel()
        let targetAmountLabel = getTargetAccountAmountLabel()
        let sourceNameLabel = getSourceAccountNameLabel()
        let targetNameLabel = getTargetAccountNameLabel()
        
        sourceAmountLabel.text = "\(data.sourceAmount)"
        targetAmountLabel.text = "\(data.targetAmount)"
        sourceNameLabel.text = data.sourceAccount
        targetNameLabel.text = data.targetAccount
        
        let padding: CGFloat = 16.0
        let middlePadding: CGFloat = 8.0
        
        let textWidth = (UIScreen.main.bounds.width - (2 * padding) - 20 - (2 * padding)) / 2
    
        let sourceNameHeight: CGFloat = sourceNameLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let targetNameHeight: CGFloat = targetNameLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let sourceAmountHeight: CGFloat = sourceNameLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let targetAmountHeight: CGFloat = targetNameLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        
        let cellHeight = (sourceNameHeight > targetNameHeight ? sourceNameHeight : targetNameHeight) + (2 * padding) + (2 * middlePadding) + (sourceAmountHeight > targetAmountHeight ? sourceAmountHeight : targetAmountHeight)
                        
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: cellHeight
        )
    }
    
}
