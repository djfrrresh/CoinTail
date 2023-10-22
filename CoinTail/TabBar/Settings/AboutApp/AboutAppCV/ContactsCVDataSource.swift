//
//  ContactsCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit


extension AboutAppVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactsMenu.count
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ContactsCell.id,
            for: indexPath
        ) as? ContactsCell else {
            return UICollectionViewCell()
        }
        
        cell.contactsLabel.text = contactsMenu[indexPath.row]
        cell.contactsImageView.image = UIImage(systemName: contactsImages[indexPath.row])
        
        switch indexPath.row {
        case 0:
            cell.cornerRadiusTop(radius: 12)
            cell.isSeparatorLineHidden(false)
        case 1:
            cell.cornerRadiusBottom(radius: 12)
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
                    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ContactsHeader.id,
            for: indexPath
        ) as? ContactsHeader else {
            return UICollectionViewCell()
        }
        
        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
    
}
