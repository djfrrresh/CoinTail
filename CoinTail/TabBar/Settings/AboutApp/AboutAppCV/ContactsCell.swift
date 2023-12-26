//
//  ContactsCell.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit
import EasyPeasy


final class ContactsCell: UICollectionViewCell {
    
    static let id = "ContactsCell"

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let contactsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = .black

        return label
    }()
    let appVersionTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Application version".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    let appVersionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor(named: "secondaryTextColor")
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            label.text = appVersion
        } else {
            label.text = "1.0"
        }
        
        return label
    }()
    let userAgreementLabel: UILabel = {
        let label = UILabel()
        label.text = "User agreement".localized()
        label.textColor = .black
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()

    let contactsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        
        return imageView
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
        
        contentView.addSubview(contactsLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
        contentView.addSubview(contactsImageView)
        contentView.addSubview(userAgreementLabel)
        contentView.addSubview(appVersionLabel)
        contentView.addSubview(appVersionTextLabel)
        
        contentView.easy.layout([
            Edges()
        ])
        
        contactsImageView.easy.layout([
            Left(16),
            CenterY()
        ])

        contactsLabel.easy.layout([
            Left(12).to(contactsImageView, .right),
            CenterY()
        ])
        
        userAgreementLabel.easy.layout([
            Left(16),
            CenterY()
        ])
        
        appVersionTextLabel.easy.layout([
            Left(16),
            Right(16),
            Top(12)
        ])
        
        appVersionLabel.easy.layout([
            Left(16),
            Right(16),
            Bottom(12)
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left().to(contactsLabel, .left),
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
            height: 44
        )
    }
    static func appVersionSize() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 72
        )
    }
    
}
