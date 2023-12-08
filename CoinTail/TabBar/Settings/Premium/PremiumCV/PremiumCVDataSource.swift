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
        case PremiumDescriptionCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumDescriptionCell.id,
                for: indexPath
            ) as? PremiumDescriptionCell else {
                return UICollectionViewCell()
            }
            
            return cell
        case PremiumPlansCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumPlansCell.id,
                for: indexPath
            ) as? PremiumPlansCell else {
                return UICollectionViewCell()
            }
            
            cell.plansDelegate = self
            cell.planCellData = plans
            cell.planCellSize = .init(
                width: planCellSizes.sorted(by: { l, r in
                    l.width > r.width
                }).first?.width ?? 0,
                height: max(planCellSizes.sorted(by: { l, r in
                    l.height > r.height
                }).first?.height ?? 0, 120)
            )

            return cell
        case PremiumAdvantagesCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumAdvantagesCell.id,
                for: indexPath
            ) as? PremiumAdvantagesCell else {
                return UICollectionViewCell()
            }
            
            cell.advantagesCellData = AdvantagesData.advantages

            return cell
        case PremiumPrivacyCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PremiumPrivacyCell.id,
                for: indexPath
            ) as? PremiumPrivacyCell else {
                return UICollectionViewCell()
            }
            
            cell.setupDescriptionLabelText(plan ?? plans.sorted(by: { l, r in
                l.isTrial && !r.isTrial
            }).first!)

            cell.privacyDelegate = self

            return cell
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return PremiumDescriptionCell.id
        case 1:
            return PremiumPlansCell.id
        case 2:
            return PremiumAdvantagesCell.id
        case 3:
            return PremiumPrivacyCell.id
        default:
            fatalError("error: supporting only 4 section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PremiumPlansHeader.id,
            for: indexPath
        ) as? PremiumPlansHeader else {
            return UICollectionViewCell()
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case PremiumDescriptionCell.id:
            return .init(top: 0, left: 0, bottom: 28, right: 0)
        case PremiumPlansCell.id:
            return .init(top: 0, left: 0, bottom: 32, right: 0)
        case PremiumAdvantagesCell.id:
            return .init(top: 0, left: 0, bottom: 16, right: 0)
        case PremiumPrivacyCell.id:
            return .init(top: 0, left: 0, bottom: 20, right: 0)
        default:
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case PremiumDescriptionCell.id:
            return CGSize()
        case PremiumPlansCell.id:
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        case PremiumAdvantagesCell.id:
            return CGSize()
        case PremiumPrivacyCell.id:
            return CGSize()
        default:
            return CGSize()
        }
    }
    
}
