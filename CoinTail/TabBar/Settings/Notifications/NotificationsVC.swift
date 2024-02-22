//
//  NotificationsVC.swift
//  CoinTail
//
//  Created by Eugene on 15.09.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
    
    let bellEmojiLabel: UILabel = getDataEmojiLabel("🔔")
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notifications".localized()
        
        notificationsCV.delegate = self

        notificationsCV.dataSource = self
                
        notificationsSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notificationsCV.reloadData()
        
        navigationController?.navigationBar.isHidden = false
    }
    
}
