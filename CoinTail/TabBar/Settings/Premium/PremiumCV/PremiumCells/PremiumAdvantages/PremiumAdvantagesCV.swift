//
//  PremiumAdvantagesCV.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import UIKit


extension PremiumAdvantagesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advantagesCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AdvantagesCell.id,
            for: indexPath
        ) as? AdvantagesCell else {
            return UICollectionViewCell()
        }
        
        cell.advantageLabel.text = advantagesCellData[indexPath.item].descriptionText
        cell.advantageIcon.text = advantagesCellData[indexPath.item].icon
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AdvantagesCell.size(data: advantagesCellData[indexPath.item])
    }
    
}
