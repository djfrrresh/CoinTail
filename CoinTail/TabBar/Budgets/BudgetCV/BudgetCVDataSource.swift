//
//  BudgetCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 30.06.23.
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
        var sumByCategory: Double = 0
        
        if let budget = Budgets.shared.getBudget(for: budgetData.id) {
            Records.shared.getBudgetAmount(budgetID: budget.id) { totalAmount in
                if let totalAmount = totalAmount {
                    sumByCategory += abs(totalAmount)

                    let percentText = cell.calculatePercent(sum: sumByCategory, total: budgetData.amount)
                    let formattedAmount = String(format: "%.2f", sumByCategory)
                    
                    cell.amountLabel.text = "\(formattedAmount) / \(budgetData.amount) \(budgetData.currency) (\(percentText)%)"
                    cell.isSumExceedsBudget(sumByCategory: sumByCategory, budgetSum: budgetData.amount)
                } else {
                    SentryManager.shared.capture(error: "Empty amount in BudgetVC", level: .error)
                    print("Failed to calculate total amount.")
                    cell.amountLabel.text = "\(0.00) / \(budgetData.amount) \(budgetData.currency) (0%)"
                }
            }
        }
        
        guard let category = Categories.shared.getCategory(for: budgetData.categoryID) else {
            SentryManager.shared.capture(error: "No category for budget", level: .error)
            
            return cell
        }

        cell.categoryLabel.text = category.name
        cell.categoryIcon.text = category.image
                
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
