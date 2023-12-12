//
//  OperationCell.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import EasyPeasy


final class OperationCVCell: UICollectionViewCell {
    
    static let id = "OperationCVCell"

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    let categoryIcon: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 32)
        label.backgroundColor = .clear
        
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
        contentView.addSubview(categoryIcon)
        contentView.addSubview(amountLabel)
        contentView.addSubview(categoryLabel)
        
        contentView.easy.layout([
            Edges()
        ])

        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left(16),
            Height(0.5)
        ])
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
        
        categoryIcon.easy.layout([
            CenterY(),
            Left(16),
            Height(32),
            Width(32)
        ])
        
        categoryLabel.easy.layout([
            Left(16).to(categoryIcon, .right),
            Right(16).to(chevronImageView, .left),
            Top(12)
        ])
        
        amountLabel.easy.layout([
            Left(16).to(categoryIcon, .right),
            Right(16).to(chevronImageView, .left),
            Bottom(12)
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    // Ставит цвет текста в зависимости от типа операции
    func setAmountColor(recordType: RecordType) {
        switch recordType {
        case .expense:
            amountLabel.textColor = .systemRed
        case .income:
            amountLabel.textColor = .systemGreen
        default:
            amountLabel.textColor = .black
        }
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 72
        )
    }
    
}
