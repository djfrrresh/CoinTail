//
//  RegularityCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 20.10.23.
//

import UIKit


extension RegularityVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regularityMenu.count
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RegularityCell.id,
            for: indexPath
        ) as? RegularityCell else {
            return UICollectionViewCell()
        }
        
        cell.menuLabel.text = regularityMenu[indexPath.row].localized()
        cell.checkmarkImageView.isHidden = regularityMenu[indexPath.row].localized() != selectedRegularity.rawValue.localized()
        
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
    
}
