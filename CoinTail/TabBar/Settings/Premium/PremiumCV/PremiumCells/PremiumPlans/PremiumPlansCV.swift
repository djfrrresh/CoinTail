//
//  PremiumPlansCV.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
