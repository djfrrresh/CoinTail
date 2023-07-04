//
//  HomeOperationCellCV.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

import UIKit


protocol PushVC: AnyObject {
    func pushVC(record: Record)
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
            fatalError("Unable to dequeue DateCVCell.")
        }
        
        let recordData: Record
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        let image = recordData.category.image
        let amount = "\(recordData.amount)"
        let category = recordData.category.name
        let backView = recordData.category.color
                
        cell.amountLabel.text = amount
        cell.categoryLabel.text = category
        cell.categoryImage.image = image
        cell.backImage.backgroundColor = backView
        
        // Ставит цвет в зависимости от типа операции
        cell.setAmountColor(
            recordType: RecordType(rawValue: (recordData.type).rawValue ) ?? .allOperations,
            amountLabel: cell.amountLabel
        )
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recordData: Record
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        pushVCDelegate?.pushVC(record: recordData)
    }
    
    // Определение размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let recordData: Record?
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        guard let record = recordData else { return .init(width: 0, height: 0) }

        return OperationCVCell.size(data: record)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: OperationCVHeader.id,
            for: indexPath) as? OperationCVHeader else { fatalError("Unable to dequeue OperationCVHeader.")
        }
        
        
        let section = monthSectionsCellData[indexPath.section]
        let date = section.month
        
        headerView.dateLabel.text = headerView.dateFormatter.string(from: date)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 32)
    }
    
}
