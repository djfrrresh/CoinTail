//
//  HomeOperationCellCV.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

import UIKit


extension HomeOperationCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return monthSectionsCellData.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let monthSection = monthSectionsCellData[section].records

        return monthSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OperationCVCell.id, for: indexPath) as? OperationCVCell else {
            fatalError("Unable to dequeue DateCVCell.")
        }
        
        let recordData: Record?
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        let image = recordData?.categoryImage
        let amount = "\(recordData?.amount ?? 1)"
        let category = recordData?.categoryText
        let backView = recordData?.categoryColor
                
        cell.amountLabel.text = amount
        cell.categoryLabel.text = category
        cell.categoryImage.image = image
        cell.backImage.backgroundColor = backView
        
        // Ставит цвет в зависимости от типа операции
        cell.setAmountColor(
            recordType: RecordType(rawValue: (recordData?.type)?.rawValue ?? "allOperations") ?? .allOperations,
            amountLabel: cell.amountLabel
        )
                
        return cell
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let recordData: Record?
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        guard let record = recordData else { return .init(width: 0, height: 0) }

        return OperationCVCell.size(data: record)
    }
    
}
