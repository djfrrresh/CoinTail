//
//  PremiumPlansCV.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import UIKit


extension PremiumPlansCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectedCell {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlanCell.id,
            for: indexPath
        ) as? PlanCell else {
            return UICollectionViewCell()
        }
        
        cell.planDelegate = self
        cell.titleLabel.text = planCellData[indexPath.item].title
        cell.priceLabel.text = "₽ \(planCellData[indexPath.item].price)/\(planCellData[indexPath.item].period)"
        cell.roundCorners(.allCorners, radius: 16)
        cell.setTrialIndicator(planCellData[indexPath.item].promoText)
                
        if let selectedPlan = plansDelegate?.selectedPlan {
            cell.selectedCell = selectedPlan == planCellData[indexPath.item] ? indexPath : nil
        } else {
            cell.selectedCell = nil
        }
        
        return cell
    }
    
    func scrollToSelectedCell(indexPath: IndexPath) {
        plansCV.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        guard let cell = collectionView.cellForItem(at: indexPath) as? PlanCell else { return }
        
        plansDelegate?.selectedPlanCell(indexPath.item, isSelectedBefore: (cell.selectedCell != nil))

        for i in 0..<planCellData.count {
            if let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? PlanCell {
                let anotherСell = cell
                anotherСell.selectedCell = anotherСell == cell ? indexPath : nil
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return planCellSize
    }
    
}
