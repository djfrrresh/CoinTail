//
//  RegularityCell.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit
import EasyPeasy


final class RegularityCell: UICollectionViewCell {
    
    static let id = "RegularityCell"

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "black")
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()

    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "checkMark")
        
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.backgroundColor = .white
        
        contentView.addSubview(menuLabel)
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(separatorView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.easy.layout([
            Edges()
        ])

        menuLabel.easy.layout([
            Left(16),
            CenterY()
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left(16),
            Height(0.5)
        ])
        
        checkmarkImageView.easy.layout([
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
            height: 44
        )
    }
    
}
