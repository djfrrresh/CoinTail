//
//  SettingsCell.swift
//  CoinTail
//
//  Created by Eugene on 30.08.23.
//

import UIKit
import EasyPeasy


final class SettingsCell: UICollectionViewCell {
    
    static let id = "SettingsCell"
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10

        return view
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left

        return label
    }()
    
    let menuImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backView)
        backView.addSubview(menuImage)
        backView.addSubview(menuLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Left(),
            Right(),
            Top(4),
            Bottom(4)
        ])
        
        menuImage.easy.layout([
            Left(),
            CenterY(),
            Height(40),
            Width(40)
        ])

        menuLabel.easy.layout([
            Left(16).to(menuImage, .right),
            CenterY()
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 60
        )
    }
    
}


