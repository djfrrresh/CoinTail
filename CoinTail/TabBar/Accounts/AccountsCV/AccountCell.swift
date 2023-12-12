//
//  AccountCell.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit
import EasyPeasy


final class AccountCell: UICollectionViewCell {
    
    static let id = "AccountCell"

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = .black
        
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
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
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(chevronImageView)
        
        contentView.easy.layout([
            Edges()
        ])
        
        nameLabel.easy.layout([
            Left(16),
            Top(12)
        ])
        
        amountLabel.easy.layout([
            Left(16),
            Bottom(12)
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
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 72
        )
    }
    
}
