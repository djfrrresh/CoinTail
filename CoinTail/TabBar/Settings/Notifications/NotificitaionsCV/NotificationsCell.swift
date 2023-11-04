//
//  NotificationsCell.swift
//  CoinTail
//
//  Created by Eugene on 19.10.23.
//

import UIKit
import EasyPeasy


final class NotificationsCell: UICollectionViewCell {
    
    static let id = "NotificationsCell"
            
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()
    let regularityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")

        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let onOffToggle: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = Notifications.shared.toggleStatus
        
        return uiSwitch
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.addSubview(backView)
        
        backView.addSubview(menuLabel)
        backView.addSubview(chevronImageView)
        backView.addSubview(regularityLabel)
        backView.addSubview(separatorView)
        backView.addSubview(onOffToggle)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
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
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
        
        regularityLabel.easy.layout([
            CenterY(),
            Right(4).to(chevronImageView, .left)
        ])
        
        onOffToggle.easy.layout([
            Right(16),
            CenterY()
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
