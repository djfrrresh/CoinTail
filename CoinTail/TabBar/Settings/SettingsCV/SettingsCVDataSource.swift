//
//  SettingsCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 30.08.23.
//

import UIKit


extension SettingsVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return settingsMenu.count
        case 1:
            return 1
        default:
            return 0
        }
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellIdentifier(for: indexPath) {
        case SettingsCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SettingsCell.id,
                for: indexPath
            ) as? SettingsCell else {
                return UICollectionViewCell()
            }
            
            cell.menuLabel.text = settingsMenu[indexPath.row]
            cell.menuImageView.image = UIImage(systemName: settingsMenuImages[indexPath.row])
            cell.menuImageView.tintColor = UIColor(named: settingsMenuColors[indexPath.row])
            
            switch indexPath.row {
            case 0:
                cell.cornerRadiusTop(radius: 12)
                cell.currencyLabel.isHidden = false
                cell.currencyLabel.text = selectedCurrency
                cell.isSeparatorLineHidden(false)
            case 4:
                cell.cornerRadiusBottom(radius: 12)
                cell.currencyLabel.isHidden = true
                cell.isSeparatorLineHidden(true)
            default:
                return cell
            }
            
            return cell
        case SettingsPremiumCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SettingsPremiumCell.id,
                for: indexPath
            ) as? SettingsPremiumCell else {
                return UICollectionViewCell()
            }
            
            return cell
        default:
            fatalError("error: supporting only 2 section")
        }
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return SettingsCell.id
        case 1:
            return SettingsPremiumCell.id
        default:
            fatalError("error: supporting only 2 section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return .init(top: 24, left: 0, bottom: 24, right: 0)
        case 1:
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        default:
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

}
