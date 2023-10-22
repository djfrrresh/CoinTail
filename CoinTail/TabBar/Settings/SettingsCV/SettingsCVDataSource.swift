//
//  SettingsCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 30.08.23.
//

import UIKit


extension SettingsVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsMenu.count
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    
}
