//
//  HavePremiumImageCell.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit
import EasyPeasy


final class HavePremiumImageCell: UICollectionViewCell {
    
    static let id = "HavePremiumImageCell"
    
    private let popperImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popperEmoji")
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(popperImageView)
        
        popperImageView.easy.layout([
            Height(200),
            Width(200),
            Center()
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: 200,
            height: 200
        )
    }
    
}
