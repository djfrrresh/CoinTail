//
//  NotificationsVC.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//

import UIKit
import UserNotifications


final class NotificationsVC: BasicVC {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var notificationRegularity = Notifications.shared.regularity
    
    let notificationsMenu = [
        "Push notifications".localized(),
        "Regularity".localized()
    ]
    
    let notificationsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Set a reminder".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    let notificationsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Never miss a transaction! Enable push notifications to stay on top of your finances".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    
    let bellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bellEmoji")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let notificationsCV: UICollectionView = {
        let notificationsLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: notificationsLayout)
        cv.backgroundColor = .clear
        cv.register(NotificationsCell.self, forCellWithReuseIdentifier: NotificationsCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notificationsCV.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notifications".localized()
        
        notificationsCV.delegate = self

        notificationsCV.dataSource = self
                
        notificationsSubviews()
    }
    
}
