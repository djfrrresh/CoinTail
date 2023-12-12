//
//  SettingsPremiumCell.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit
import EasyPeasy


final class SettingsPremiumCell: UICollectionViewCell {
    
    static let id = "SettingsPremiumCell"
    
    let premiumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.textColor = .white
        label.text = "Upgrade to premium".localized()

        return label
    }()
    let premiumDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Get even more features with our Premium subscription".localized()
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        
        return label
    }()
    
    let boltImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "primaryAction")
        imageView.image = UIImage(systemName: "bolt.fill")
        
        return imageView
    }()
    
    let boltImageBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.backgroundColor = UIColor(named: "primaryAction")
        contentView.layer.cornerRadius = 16
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(boltImageBackView)
        contentView.addSubview(premiumLabel)
        contentView.addSubview(premiumDescription)
                
        contentView.easy.layout([
            Edges()
        ])
        
        boltImageBackView.easy.layout([
            Height(48),
            Width(48),
            CenterY(),
            Left(16)
        ])
        
        boltImageBackView.addSubview(boltImageView)

        boltImageView.easy.layout([
            Height(24),
            Width(24),
            Center()
        ])

        premiumLabel.easy.layout([
            Left(16).to(boltImageBackView, .right),
            Right(16),
            Top(16)
        ])
        
        premiumDescription.easy.layout([
            Left(16).to(boltImageBackView, .right),
            Right(16),
            Bottom(16)
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 88
        )
    }
    
}
