//
//  TransfersHistoryCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
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


extension TransfersHistoryVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return transfersDaySections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dayItems = transfersDaySections[section].transfers
        
        return dayItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransfersHistoryCell.id,
            for: indexPath
        ) as? TransfersHistoryCell else {
            return UICollectionViewCell()
        }
        
        let section = transfersDaySections[indexPath.section]
        let transferData: TransferHistoryClass = section.transfers[indexPath.row]

        let formattedSourceAmount = String(format: "%.2f", transferData.sourceAmount)
        let formattedTargetAmount = String(format: "%.2f", transferData.targetAmount)

        cell.sourceAmountLabel.text = "- \(formattedSourceAmount) \(transferData.sourceCurrency)"
        cell.targetAmountLabel.text = "+ \(formattedTargetAmount) \(transferData.targetCurrency)"
        cell.sourceAccountLabel.text = transferData.sourceAccount
        cell.targetAccountLabel.text = transferData.targetAccount
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TransfersHistoryCVHeader.id,
            for: indexPath
        ) as? TransfersHistoryCVHeader else {
            return UICollectionViewCell()
        }
        
        let section = transfersDaySections[indexPath.section]
        let transferData: TransferHistoryClass = section.transfers[indexPath.row]
        
        headerView.dateLabel.text = headerView.headerDF.string(from: transferData.date)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}
