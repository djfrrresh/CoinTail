//
//  AddBudgetCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
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


extension AddBudgetVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return budgetID != nil ? 3 : 4
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddBudgetCell.id,
            for: indexPath
        ) as? AddBudgetCell else {
            return UICollectionViewCell()
        }
        
        cell.addBudgetCellDelegate = self
                        
        switch indexPath.row {
        case 0:
            cell.cornerRadiusTop(radius: 12)
            cell.budgetAmountTF.placeholder = "Amount".localized()
            if budgetID != nil {
                cell.budgetAmountTF.text = budgetAmount
            }

            cell.budgetAmountTF.isHidden = false
            cell.menuLabel.isHidden = true
            cell.subMenuLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.isSeparatorLineHidden(false)
        case 1:
            cell.menuLabel.text = "Currency".localized()
            cell.subMenuLabel.text = selectedCurrency

            cell.budgetAmountTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.subMenuLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.isSeparatorLineHidden(false)
        case 2:
            cell.menuLabel.text = "Category".localized()
            cell.subMenuLabel.text = budgetCategory

            cell.budgetAmountTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.subMenuLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            if budgetID != nil {
                cell.isSeparatorLineHidden(true)
                cell.cornerRadiusBottom(radius: 12)
            } else {
                cell.isSeparatorLineHidden(false)
            }
        case 3:
            cell.cornerRadiusBottom(radius: 12)
            cell.menuLabel.text = "Time period".localized()
            cell.subMenuLabel.text = budgetTimePeriod

            cell.budgetAmountTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.subMenuLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
                    
        return cell
    }
    
}
