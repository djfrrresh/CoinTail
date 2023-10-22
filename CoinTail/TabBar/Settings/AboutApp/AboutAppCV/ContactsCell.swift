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
    
    let contactsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
                
        contentView.addSubview(backView)
        
        backView.addSubview(contactsLabel)
        backView.addSubview(chevronImageView)
        backView.addSubview(separatorView)
        backView.addSubview(contactsImageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
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
    
}
