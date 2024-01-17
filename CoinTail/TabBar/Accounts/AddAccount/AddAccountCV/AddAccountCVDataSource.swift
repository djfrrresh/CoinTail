//
//  AddAccountCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 31.10.23.
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


extension AddAccountVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddAccountCell.id,
            for: indexPath
        ) as? AddAccountCell else {
            return UICollectionViewCell()
        }
        
        cell.addAccountCellDelegate = self
                        
        switch indexPath.row {
        case 0:
            cell.cornerRadiusTop(radius: 12)
            if accountID != nil {
                cell.accountNameTF.text = accountName
            }
            
            cell.menuLabel.isHidden = true
            cell.accountNameTF.isHidden = false
            cell.accountAmountTF.isHidden = true
            cell.currencyLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.onOffToggle.isHidden = true
            cell.isSeparatorLineHidden(false)
        case 1:
            if accountID != nil {
                cell.accountAmountTF.text = accountAmount
            }
            
            cell.menuLabel.isHidden = true
            cell.accountAmountTF.isHidden = false
            cell.accountNameTF.isHidden = true
            cell.currencyLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.onOffToggle.isHidden = true
            cell.isSeparatorLineHidden(false)
        case 2:
            cell.cornerRadiusBottom(radius: 12)
            cell.menuLabel.text = "Currency".localized()
            cell.currencyLabel.text = selectedCurrency
            
            cell.accountNameTF.isHidden = true
            cell.accountAmountTF.isHidden = true
            cell.menuLabel.isHidden = false
            cell.currencyLabel.isHidden = false
            cell.chevronImageView.isHidden = false
            cell.onOffToggle.isHidden = true
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
                    
        return cell
    }
    
}
