//
//  HavePremiumTitleCell.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit
import EasyPeasy


final class HavePremiumTitleCell: UICollectionViewCell {
    
    static let id = "YouSubscribedTitle"

    let premiumLabel: UILabel = {
        let label = UILabel()
        label.text = "👑 " + "Premium".localized()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let premiumView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "primaryAction")
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(premiumView)
        
        premiumView.addSubview(premiumLabel)
        
        premiumView.easy.layout([
            Center(),
            Width(128),
            Height(32)
        ])
        
        premiumLabel.easy.layout([
            Center()
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width,
            height: 44
        )
    }
    
}
