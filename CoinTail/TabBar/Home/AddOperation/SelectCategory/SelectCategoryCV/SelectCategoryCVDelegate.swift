//
//  SelectCategoryCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
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


extension SelectCategoryVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var categoryData: CategoryProtocol
        
        if isSearching {
            categoryData = filteredData[indexPath.row]
        } else {
            categoryData = categories[indexPath.row]
        }
        
        if isEditingCategory {
            let vc = CreateCategoryVC(categoryID: categoryData.id, segmentTitle: operationSegmentType.rawValue)
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            if isParental {
                let vc = SelectCategoryVC(segmentTitle: operationSegmentType.rawValue, isParental: false, categoryID: categoryData.id)
                vc.categoryDelegate = categoryDelegate
                
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let categoryID = categoryData.id
                
                categoryDelegate?.sendCategoryData(id: categoryID)
                
                if let navigationController = navigationController {
                    navigationController.popToViewController(navigationController.viewControllers[1], animated: true)
                } else {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        
        isSearching = false
        isEditingCategory = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return SelectCategoryCell.size()
    }
    
}
