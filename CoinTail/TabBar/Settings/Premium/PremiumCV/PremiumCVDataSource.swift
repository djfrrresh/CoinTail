//
//  PremiumCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit


extension PremiumVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
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
            
            return cell
        case SettingsPremiumCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SettingsPremiumCell.id,
                for: indexPath
            ) as? SettingsPremiumCell else {
                return UICollectionViewCell()
            }
            
            return cell
        case SettingsCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SettingsCell.id,
                for: indexPath
            ) as? SettingsCell else {
                return UICollectionViewCell()
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
            fatalError("error: supporting only 4 section")
        }
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return SettingsCell.id
        case 1:
            return SettingsCell.id
        case 2:
            return SettingsCell.id
        case 3:
            return SettingsCell.id
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 24, right: 0)
    }

}
