//
//  BudgetCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
//

import UIKit


extension BudgetsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return budgets.filter { $0.isActive }.count
        } else {
            return budgets.filter { !$0.isActive }.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BudgetCell.id,
            for: indexPath
        ) as? BudgetCell else {
            return UICollectionViewCell()
        }
        
        var filteredBudgets: [BudgetClass] = []

        if indexPath.section == 0 {
            filteredBudgets = budgets.filter { $0.isActive }
        } else {
            filteredBudgets = budgets.filter { !$0.isActive }
        }

        let budgetData: BudgetClass = filteredBudgets[indexPath.row]
        let currency = budgetData.currency
        let categoryID = budgetData.categoryID
        guard let category = Categories.shared.getCategory(for: categoryID) else { return cell }

        let sumByCategory = abs(Records.shared.getBudgetAmount(
            date: budgetData.startDate,
            untilDate: budgetData.untilDate,
            categoryID: categoryID,
            currency: currency
        ) ?? 0)
        let percentText = cell.calculatePercent(sum: sumByCategory, total: budgetData.amount)

        cell.categoryLabel.text = category.name
        cell.amountLabel.text = "\(sumByCategory) / \(budgetData.amount) \(budgetData.currency) (\(percentText)%)"
        cell.categoryIcon.text = category.image
        
        cell.isSumExceedsBudget(sumByCategory: sumByCategory, budgetSum: budgetData.amount)
        
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

        let isSectionEmpty: Bool
        if indexPath.section == 0 {
            isSectionEmpty = budgets.filter { $0.isActive }.isEmpty
        } else {
            isSectionEmpty = budgets.filter { !$0.isActive }.isEmpty
        }

        if !isSectionEmpty {
            headerView.separatorLabel.text = indexPath.section == 0 ? "Active budgets".localized() : "Non active budgets".localized()
            headerView.isHidden = false
        } else {
            headerView.isHidden = true
        }

        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}
