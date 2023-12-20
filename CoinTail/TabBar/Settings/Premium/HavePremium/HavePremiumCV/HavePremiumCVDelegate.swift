//
//  HavePremiumCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 19.12.23.
//

import UIKit


extension HavePremiumVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellIdentifier(for: indexPath) {
        case HavePremiumTitleCell.id:
            return HavePremiumTitleCell.size()
        case HavePremiumImageCell.id:
            return HavePremiumImageCell.size()
        case PremiumDescriptionCell.id:
            return PremiumDescriptionCell.size(
                description: "You have bought a premium subscription".localized())
        case PremiumAdvantagesCell.id:
            return PremiumAdvantagesCell.size(data: advantages)
        case HavePremiumDateCell.id:
            return HavePremiumDateCell.size()
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
}
