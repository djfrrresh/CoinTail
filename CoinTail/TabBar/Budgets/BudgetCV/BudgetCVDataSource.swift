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
        let dayItems = daySections[section].budgets
        
        return dayItems.count
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
        let sumByCategory = abs(Records.shared.getAmount(
            date: budgetData.startDate,
            untilDate: budgetData.untilDate,
            category: budgetData.category
        ) ?? 0)
        let percentText = cell.calculatePercent(sum: sumByCategory, total: budgetData.amount)
        
        cell.calculateProgressView(sum: sumByCategory, total: budgetData.amount)
        cell.categoryLabel.text = budgetData.category.name
        cell.amountLabel.text = "\(sumByCategory) / \(budgetData.amount) (\(percentText)%)"
        cell.categoryImage.image = budgetData.category.image
        cell.backImage.backgroundColor = budgetData.category.color
        
        return cell
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return BudgetCell.size()
    }
    
    // Header в виде даты окончания действия бюджета
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
        let activeSectionIndex = daySections.firstIndex { $0.budgets[0].isActive ?? false }
        let nonActiveSectionIndex = daySections.firstIndex { !($0.budgets[0].isActive ?? false) }
        
        headerView.separatorLabel.text = indexPath.section == activeSectionIndex ? "Active".localized() : "Non active".localized()
        
        headerView.dateLabel.text = headerView.headerDF.string(from: day)
        headerView.separator(isVisible: indexPath.section == activeSectionIndex || indexPath.section == nonActiveSectionIndex)

        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 32)
    }
    
}
