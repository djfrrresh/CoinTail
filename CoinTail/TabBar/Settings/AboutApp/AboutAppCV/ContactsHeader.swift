//
//  ContactsHeader.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit
import EasyPeasy


final class ContactsHeader: UICollectionReusableView {
    
    static let id = "ContactsHeader"

    let contactUsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.text = "Contact us"
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(contactUsLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contactUsLabel.easy.layout([
            Bottom(8),
            Left(16)
        ])
    }
    
}
