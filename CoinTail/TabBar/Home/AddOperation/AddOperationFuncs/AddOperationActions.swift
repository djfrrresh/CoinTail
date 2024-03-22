//
//  AddOperationActions.swift
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
import EasyPeasy
import RealmSwift


extension AddOperationVC {
    
    // Сохранение операции
    @objc func saveButtonAction(sender: AnyObject) {
        let amount = Double(operationAmount ?? "0") ?? 0
        let categoryText = operationCategory ?? ""
        let desctiption = operationDescription
        let accountID: ObjectId? = self.accountID

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
                
                let notificationView = BasicSnackBarView(title: "Edited transaction - ".localized() + categoryText, image: UIImage(systemName: "square.and.pencil")!)
                notificationView.show()
            } else {
                Records.shared.addRecord(record: record)
                
                let notificationView = BasicSnackBarView(title: "Added transaction - ".localized() + categoryText, image: UIImage(systemName: "plus")!)
                notificationView.show()
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
            addOperationSegment = RecordType.expense
        case 1:
            addOperationSegment = RecordType.income
        default:
            addOperationSegment = RecordType.expense
        }
    }
    
    // Переход на экран с выбором категории
    @objc func goToSelectCategoryVC() {
        var segmentTitle: String
        switch addOperationTypeSwitcher.selectedSegmentIndex {
        case 0:
            segmentTitle = "Expense"
        case 1:
            segmentTitle = "Income"
        default:
            segmentTitle = "Expense"
        }
        
        let vc = SelectCategoryVC(segmentTitle: segmentTitle, isParental: true, categoryID: nil)
        vc.categoryDelegate = self
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToAccountsVC() {
        let vc = AccountsVC(isSelecting: true)
        vc.accountDelegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Удаление выбранной операции по ее ID
    @objc func removeOperation() {
        guard let id = recordID else { return }
        
        confirmationAlert(
            title: "Delete transaction".localized(),
            message: "Are you sure?".localized(),
            confirmActionTitle: "Confirm".localized()
        ) { [weak self] in
            let categoryText = self?.operationCategory ?? ""
            let notificationView = BasicSnackBarView(title: "Deleted transaction - ".localized() + categoryText, image: UIImage(systemName: "trash")!)
            notificationView.show()
            
            Records.shared.deleteRecord(for: id)
            
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
