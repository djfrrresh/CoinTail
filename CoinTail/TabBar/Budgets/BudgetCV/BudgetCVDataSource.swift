//
//  BudgetCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
//

import UIKit


extension BudgetsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return daySections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let daySection = daySections[section].budgets
        
        return daySection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BudgetCell.id,
            for: indexPath
        ) as? BudgetCell else {
            fatalError("Unable to dequeue BudgetCell.")
        }
        
        let section = daySections[indexPath.section]
        let budgetData: Budget = section.budgets[indexPath.row]
        let sumByCategory = Records.shared.getAmount(date: budgetData.startDate, untilDate: budgetData.untilDate, category: budgetData.category)
        let sumByCategoryString = sumByCategory == nil ? "Error" : "\(abs(sumByCategory!))"
        
        cell.calculateProgressView(amount: abs(sumByCategory ?? 0), total: budgetData.amount)
                
        cell.categoryLabel.text = budgetData.category.name
        cell.amountLabel.text = "\(sumByCategoryString) / \(budgetData.amount)"
        cell.categoryImage.image = budgetData.category.image
        cell.backImage.backgroundColor = budgetData.category.color
        
        return cell
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return BudgetCell.size()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: BudgetCVHeader.id,
            for: indexPath
        ) as? BudgetCVHeader else {
            fatalError("Unable to dequeue BudgetCVHeader.")
        }
        
        let section = daySections[indexPath.section]
        let day = section.day
        
        headerView.dateLabel.text = headerView.dateFormatter.string(from: day)

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 32)
    }
    
}
