//
//  AddOperationCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.11.23.
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


extension AddOperationVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                goToSelectCategoryVC()
            case 2:
                // TODO: сделать переход на экран с выбором счетов
                if !accountNames.isEmpty {
                    isUsingCurrenciesPicker = false
                    showPickerView()
                    
                    selectedAccount = accountNames[0]
                } else {
                    infoAlert("You don't have any accounts to choose from".localized())
                }
            case 3:
                isUsingCurrenciesPicker = true
                showPickerView()
                
                selectedCurrency = favouriteStringCurrencies[0]
            default:
                return
            }
        case 2:
            repeatOperationAction()
        default:
            return
        }
        
        itemsPickerView.selectRow(0, inComponent: 0, animated: false)
        itemsPickerView.reloadAllComponents()
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return AddOperationCell.size()
        case 1:
            return AddOperationCell.descriptionCellSize()
        case 2:
            return AddOperationCell.repeatOperationCellSize()
        default:
            return CGSize()
        }
    }
    
}
