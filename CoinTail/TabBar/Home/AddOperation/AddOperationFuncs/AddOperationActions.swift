//
//  AddOperationActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy
import RealmSwift


extension AddOperationVC {
    
    // Сохранение операции
    @objc func saveButtonAction(sender: AnyObject) {
        let amount = Double(operationAmount ?? "0") ?? 0
        let categoryText = operationCategory ?? ""
        let desctiption = operationDescription
        var accountID: ObjectId?
        if self.accountID != nil {
            accountID = self.accountID
        }

        recordValidation(amount: amount, categoryText: categoryText, accountID: accountID) { [weak self] categoryID in
            guard let strongSelf = self else { return }
            
            let operationAmount = strongSelf.addOperationSegment == .income ? amount : -abs(amount)
            
            let record = RecordClass()
            record.amount = operationAmount
            record.descriptionText = desctiption ?? ""
            record.date = strongSelf.operationDate ?? Date()
            record.type = strongSelf.addOperationSegment.rawValue
            record.categoryID = categoryID
            record.currency = "\(strongSelf.selectedCurrency)"
            record.accountID = accountID

            if let recordID = strongSelf.recordID {
                record.id = recordID
                Records.shared.editRecord(replacingRecord: record)
            } else {
                Records.shared.addRecord(record: record)
            }

            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // Переключение типа операции
    @objc func switchButtonAction(target: UISegmentedControl) {
        // Сбрасываем выбранную категорию
        operationCategory = ""
        
        switch addOperationTypeSwitcher.selectedSegmentIndex {
        case 0:
            addOperationSegment = RecordType.income
        case 1:
            addOperationSegment = RecordType.expense
        default:
            addOperationSegment = RecordType.income
        }
    }
    
    // Переход на экран с выбором категории
    @objc func goToSelectCategoryVC() {
        var segmentTitle: String
        switch addOperationTypeSwitcher.selectedSegmentIndex {
        case 0:
            segmentTitle = "Income"
        case 1:
            segmentTitle = "Expense"
        default:
            segmentTitle = "Income"
        }
        
        let vc = SelectCategoryVC(segmentTitle: segmentTitle, isParental: true, categoryID: nil)
        vc.categoryDelegate = self
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Удаление выбранной операции по ее ID
    @objc func removeOperation() {
        guard let id = recordID else { return }
        
        confirmationAlert(
            title: "Delete operation".localized(),
            message: "Are you sure?".localized(),
            confirmActionTitle: "Confirm".localized()
        ) { [weak self] in
            Records.shared.deleteRecord(for: id)
            
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
