//
//  AboutAppVC.swift
//  CoinTail
//
//  Created by Eugene on 06.10.23.
//

import UIKit
import EasyPeasy


final class AboutAppVC: BasicVC {
    
    let contactsMenu = [
        "E-Mail".localized(),
        "Telegram".localized()
    ]
    
    let contactsImages = [
        "envelope.fill",
        "paperplane.fill"
    ]

    var appVersionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "CoinTail is a reliable assistant in accounting for income and expenses, managing accounts and budgets".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    let coinTailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "CoinTail".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }()
    let appVersionTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Application version".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        
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
    
    let userAgreementButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = .white
        
        return button
    }()
    
    let moneyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moneyEmoji")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let contactsCV: UICollectionView = {
        let contactsLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: contactsLayout)
        cv.backgroundColor = .clear
        cv.register(ContactsCell.self, forCellWithReuseIdentifier: ContactsCell.id)
        cv.register(ContactsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContactsHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "About"
        
        contactsCV.delegate = self

        contactsCV.dataSource = self

        aboutSubviews()
        aboutTargets()
    }
 
}
