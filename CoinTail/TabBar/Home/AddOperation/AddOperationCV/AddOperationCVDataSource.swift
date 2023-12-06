//
//  AddOperationCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 15.11.23.
//

import UIKit


extension AddOperationVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recordID != nil ? 2 : 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }

    // Заполнение ячеек по их id.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddOperationCell.id,
            for: indexPath
        ) as? AddOperationCell else {
            return UICollectionViewCell()
        }
        
        cell.addOperationCellDelegate = self
                        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.cornerRadiusTop(radius: 12)
                if recordID != nil {
                    cell.operationAmountTF.text = operationAmount
                }
                
                cell.operationAmountTF.isHidden = false
                cell.menuLabel.isHidden = true
                cell.subMenuLabel.isHidden = true
                cell.chevronImageView.isHidden = true
                cell.operationDescriptionTF.isHidden = true
                cell.dateTF.isHidden = true
                cell.repeatIconImageView.isHidden = true
                cell.repeatOperationLabel.isHidden = true
                cell.isSeparatorLineHidden(false)
            case 1:
                cell.menuLabel.text = "Category".localized()
                if recordID != nil {
                    cell.subMenuLabel.text = operationCategory
                }
                
                cell.operationAmountTF.isHidden = true
                cell.menuLabel.isHidden = false
                cell.subMenuLabel.isHidden = false
                cell.chevronImageView.isHidden = false
                cell.operationDescriptionTF.isHidden = true
                cell.dateTF.isHidden = true
                cell.repeatIconImageView.isHidden = true
                cell.repeatOperationLabel.isHidden = true
                cell.isSeparatorLineHidden(false)
            case 2:
                cell.menuLabel.text = "Account".localized()
                if recordID != nil {
                    cell.subMenuLabel.text = selectedAccount
                }
                
                cell.operationAmountTF.isHidden = true
                cell.menuLabel.isHidden = false
                cell.subMenuLabel.isHidden = false
                cell.chevronImageView.isHidden = false
                cell.operationDescriptionTF.isHidden = true
                cell.dateTF.isHidden = true
                cell.repeatIconImageView.isHidden = true
                cell.repeatOperationLabel.isHidden = true
                cell.isSeparatorLineHidden(false)
            case 3:
                cell.menuLabel.text = "Currency".localized()
                cell.subMenuLabel.text = selectedCurrency
                
                cell.operationAmountTF.isHidden = true
                cell.menuLabel.isHidden = false
                cell.subMenuLabel.isHidden = false
                cell.chevronImageView.isHidden = false
                cell.operationDescriptionTF.isHidden = true
                cell.dateTF.isHidden = true
                cell.repeatIconImageView.isHidden = true
                cell.repeatOperationLabel.isHidden = true
                cell.isSeparatorLineHidden(false)
            case 4:
                cell.cornerRadiusBottom(radius: 12)
                cell.menuLabel.text = "Date".localized()
                if recordID != nil {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let dateString = dateFormatter.string(from: operationDate ?? Date())
                    cell.dateTF.text = dateString
                }
                
                cell.operationAmountTF.isHidden = true
                cell.menuLabel.isHidden = false
                cell.subMenuLabel.isHidden = true
                cell.chevronImageView.isHidden = false
                cell.operationDescriptionTF.isHidden = true
                cell.dateTF.isHidden = false
                cell.repeatIconImageView.isHidden = true
                cell.repeatOperationLabel.isHidden = true
                cell.isSeparatorLineHidden(true)
            default:
                return cell
            }
        case 1:
            cell.roundCorners(.allCorners, radius: 12)
            if recordID != nil {
                cell.operationDescriptionTF.text = operationDescription
                cell.operationDescriptionTF.textColor = UIColor(named: "black")
            }
            
            cell.operationAmountTF.isHidden = true
            cell.menuLabel.isHidden = true
            cell.subMenuLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.operationDescriptionTF.isHidden = false
            cell.dateTF.isHidden = true
            cell.repeatIconImageView.isHidden = true
            cell.repeatOperationLabel.isHidden = true
            cell.isSeparatorLineHidden(true)
        case 2:
            cell.roundCorners(.allCorners, radius: 12)
            
            cell.operationAmountTF.isHidden = true
            cell.menuLabel.isHidden = true
            cell.subMenuLabel.isHidden = true
            cell.chevronImageView.isHidden = true
            cell.operationDescriptionTF.isHidden = true
            cell.dateTF.isHidden = true
            cell.repeatIconImageView.isHidden = false
            cell.repeatOperationLabel.isHidden = false
            cell.isSeparatorLineHidden(true)
        default:
            return cell
        }
                    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 24, right: 0)
    }
    
}
