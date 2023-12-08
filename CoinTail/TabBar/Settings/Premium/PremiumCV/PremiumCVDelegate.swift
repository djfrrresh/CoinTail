//
//  PremiumCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit


extension PremiumVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        default:
            return
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellIdentifier(for: indexPath) {
        case PremiumDescriptionCell.id:
            return PremiumDescriptionCell.size()
        case PremiumPlansCell.id:
            return .init(
                width: UIScreen.main.bounds.width,
                height: max(planCellSizes.sorted(by: { l, r in
                    l.height > r.height
                }).first!.height, 120))
        case PremiumAdvantagesCell.id:
            return PremiumAdvantagesCell.size(data: AdvantagesData.advantages)
        case PremiumPrivacyCell.id:
            return PremiumPrivacyCell.size(plans)
        default:
            return CGSize()
        }
    }
    
}
