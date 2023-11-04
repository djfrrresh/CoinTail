//
//  BudgetCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
//

import UIKit


extension BudgetsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return budgetsDaySections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dayItems = budgetsDaySections[section].budgets
        
        return dayItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BudgetCell.id,
            for: indexPath
        ) as? BudgetCell else {
            return UICollectionViewCell()
        }
        
        let section = budgetsDaySections[indexPath.section]
        let budgetData: BudgetClass = section.budgets[indexPath.row]
        let currency = budgetData.currency
        let categoryID = budgetData.categoryID
        guard let category = Categories.shared.getCategory(for: categoryID),
              let image = category.image else { return cell }
                
        // TODO: проверить приходит ли в currency код валюты или название
        let sumByCategory = abs(Records.shared.getBudgetAmount(
            date: budgetData.startDate,
            untilDate: budgetData.untilDate,
            categoryID: categoryID,
            currency: currency
        ) ?? 0)
        let percentText = cell.calculatePercent(sum: sumByCategory, total: budgetData.amount)

        cell.categoryLabel.text = category.name
        cell.amountLabel.text = "\(sumByCategory) / \(budgetData.amount) \(budgetData.currency) (\(percentText)%)"
        cell.categoryImage.image = UIImage(systemName: image)
        
        let isLastRow = self.collectionView(collectionView, numberOfItemsInSection: indexPath.section) - 1 == indexPath.row
        cell.isSeparatorLineHidden(isLastRow)
        
        // Динамическое округление ячеек
        if indexPath.item == 0 && isLastRow {
            cell.roundCorners(.allCorners, radius: 12)
        } else if isLastRow {
            cell.roundCorners(bottomLeft: 12, bottomRight: 12)
        } else if indexPath.row == 0 {
            cell.roundCorners(topLeft: 12, topRight: 12)
        } else {
            cell.roundCorners(.allCorners, radius: 0)
        }
        
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
            return UICollectionViewCell()
        }
        
        let activeSectionIndex = budgetsDaySections.firstIndex { $0.budgets[0].isActive }
        let nonActiveSectionIndex = budgetsDaySections.firstIndex { !($0.budgets[0].isActive) }
        
        headerView.separatorLabel.text = indexPath.section == activeSectionIndex ? "Active budgets".localized() : "Non active budgets".localized()
        
        headerView.separator(isVisible: indexPath.section == activeSectionIndex || indexPath.section == nonActiveSectionIndex)

        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
    
}
