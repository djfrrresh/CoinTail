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
        "E-Mail",
        "Telegram"
    ]
    
    let contactsImages = [
        "envelope.fill",
        "paperplane.fill"
    ]
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    static let aboutTitleText = "CoinTail"
    static let aboutDescriptionText = "CoinTail is a reliable assistant in accounting for income and expenses, managing accounts and budgets"
    
    let aboutTitleLabel: UILabel = getNoDataLabel(text: aboutTitleText)
    let accountsDescriptionLabel: UILabel = getDataDescriptionLabel(text: aboutDescriptionText)
    let aboutImageView: UIImageView = getDataImageView(name: "moneyEmoji")
    
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
        
        self.title = "About".localized()
        
        contactsCV.delegate = self

        contactsCV.dataSource = self

        aboutSubviews()
    }
 
}
