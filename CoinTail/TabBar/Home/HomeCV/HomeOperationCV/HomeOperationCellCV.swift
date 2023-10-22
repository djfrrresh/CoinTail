//
//  HomeOperationCellCV.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

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
        
        guard let categoryData = Categories.shared.getCategory(for: recordData.categoryID),
              let image = categoryData.image else { return cell }
        
        let amount = "\(recordData.amount)"
        let category = categoryData.name
        let currency = "\(recordData.currency)"
        let backView = categoryData.color
                
        cell.amountLabel.text = amount
        cell.categoryLabel.text = category
        cell.categoryImage.image = UIImage(systemName: image)
        cell.currencyLabel.text = currency
        cell.backImage.backgroundColor = UIColor(hex: backView ?? "FFFFFF")
        
        // Ставит цвет в зависимости от типа операции
        cell.setAmountColor(
            recordType: RecordType(rawValue: recordData.type) ?? .allOperations,
            amountLabel: cell.amountLabel,
            currencyLabel: cell.currencyLabel
        )
                
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
        let recordData: RecordClass?
        let section = monthSectionsCellData[indexPath.section]
        
        recordData = section.records[indexPath.row]
        
        guard let record = recordData else { return .init(width: 0, height: 0) }

        return OperationCVCell.size(data: record)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: OperationCVHeader.id,
            for: indexPath
        ) as? OperationCVHeader else {
            return UICollectionViewCell()
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
