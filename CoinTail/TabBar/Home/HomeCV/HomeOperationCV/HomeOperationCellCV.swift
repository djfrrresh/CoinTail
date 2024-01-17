//
//  HomeOperationCellCV.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
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


protocol PushVC: AnyObject {
    func pushVC(record: RecordClass)
}

extension HomeOperationCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return monthSectionsCellData.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let monthSection = monthSectionsCellData[section].records

        return monthSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OperationCVCell.id,
            for: indexPath
        ) as? OperationCVCell else {
            return UICollectionViewCell()
        }
        
        let recordData: RecordClass
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        guard let categoryData = Categories.shared.getGeneralCategory(for: recordData.categoryID) else { return cell }

        // Ставит цвет в зависимости от типа операции
        cell.setAmountColor(recordType: RecordType(rawValue: recordData.type) ?? .allOperations)
        
        cell.categoryLabel.text = categoryData.name
        cell.amountLabel.text = "\(recordData.amount) \(recordData.currency)"
        cell.categoryIcon.text = categoryData.image
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recordData: RecordClass
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        pushVCDelegate?.pushVC(record: recordData)
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return OperationCVCell.size()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HomeOperationHeader.id,
            for: indexPath
        ) as? HomeOperationHeader else {
            return UICollectionViewCell()
        }
        
        let section = monthSectionsCellData[indexPath.section]
        let date = section.month
        
        headerView.dateLabel.text = headerView.dateFormatter.string(from: date)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}
