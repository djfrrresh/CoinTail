//
//  NotificationsCVDataSource.swift.swift
//  CoinTail
//
//  Created by Eugene on 19.10.23.
//

import UIKit


extension NotificationsVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificationsMenu.count
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NotificationsCell.id,
            for: indexPath
        ) as? NotificationsCell else {
            return UICollectionViewCell()
        }
        
        let regularitySegment: NotificationPeriods = Notifications.shared.regularity

        cell.menuLabel.text = notificationsMenu[indexPath.row]
        cell.regularityLabel.text = regularitySegment.rawValue
        cell.onOffToggle.addTarget(self, action: #selector(switchToggled), for: UIControl.Event.valueChanged)
        
        notificationsValidate(toggle: cell.onOffToggle)
        
        switch indexPath.row {
        case 0:
            cell.cornerRadiusTop(radius: 12)
            cell.regularityLabel.text = regularitySegment.rawValue
            
            cell.regularityLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.onOffToggle.isHidden = false
            cell.isSeparatorLineHidden(false)
        case 1:
            cell.cornerRadiusBottom(radius: 12)
            
            cell.regularityLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.onOffToggle.isHidden = true
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
                    
        return cell
    }
    
}
