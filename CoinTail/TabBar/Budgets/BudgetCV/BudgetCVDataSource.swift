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
        let categoryID = budgetData.categoryID
        
        guard let category = Categories.shared.getCategory(for: categoryID),
              let image = category.image,
              let currency = Currency(rawValue: budgetData.currency) else { return cell }
        
        // TODO: проверить приходит ли в currency код валюты или название
        let sumByCategory = abs(Records.shared.getBudgetAmount(
            date: budgetData.startDate,
            untilDate: budgetData.untilDate,
            categoryID: categoryID,
            currency: currency
        ) ?? 0)
        let percentText = cell.calculatePercent(sum: sumByCategory, total: budgetData.amount)
        
        cell.calculateProgressView(sum: sumByCategory, total: budgetData.amount)
        cell.categoryLabel.text = category.name
        cell.amountLabel.text = "\(sumByCategory) / \(budgetData.amount)"
        cell.categoryImage.image = UIImage(systemName: image)
        cell.backImage.backgroundColor = UIColor(hex: category.color ?? "FFFFFF")
        cell.currencyLabel.text = "\(budgetData.currency) (\(percentText)%)"
        
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
        
        let section = budgetsDaySections[indexPath.section]
        let day = section.day
        let activeSectionIndex = budgetsDaySections.firstIndex { $0.budgets[0].isActive ?? false }
        let nonActiveSectionIndex = budgetsDaySections.firstIndex { !($0.budgets[0].isActive ?? false) }
        
        headerView.separatorLabel.text = indexPath.section == activeSectionIndex ? "Active".localized() : "Non active".localized()
        
        headerView.dateLabel.text = headerView.headerDF.string(from: day)
        headerView.separator(isVisible: indexPath.section == activeSectionIndex || indexPath.section == nonActiveSectionIndex)

        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 32)
    }
    
}
