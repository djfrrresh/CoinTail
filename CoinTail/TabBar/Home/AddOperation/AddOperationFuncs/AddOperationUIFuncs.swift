//
//  AddOperationUIFuncs.swift
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


extension AddOperationVC: UIScrollViewDelegate {
    
    func setupUI(with record: RecordClass) {    
        deleteOperationButton.isHidden = false
        
        // Дата
        operationDate = record.date

        guard let recordType = RecordType(rawValue: record.type) else {
            SentryManager.shared.capture(error: "No RecordType to get", level: .error)
            
            return
        }

        // Тип операции
        addOperationSegment = recordType
        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .expense ? 0 : 1
        addOperationTypeSwitcher.isHidden = true

        // Сумма
        operationAmount = "\(record.amount)"
        
        // Описание
        operationDescription = record.descriptionText

        // Категория
        self.categoryID = record.categoryID
        guard let category = Categories.shared.getGeneralCategory(for: record.categoryID) else {
            SentryManager.shared.capture(error: "No generalCategory to get", level: .error)
            
            return
        }
        operationCategory = category.name
        
        // Счет
        if let accountID = record.accountID, let account = Accounts.shared.getAccount(for: accountID) {
            selectedAccount = account.name
        }
        
        selectedCurrency = record.currency
    }
    
    func addOperationNavBar() {
        let saveButton = UIBarButtonItem(title: "Save".localized(), style: .plain, target: self, action: #selector(saveButtonAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func addOperationSubviews() {
        self.view.addSubview(addOperationTypeSwitcher)
        self.view.addSubview(addOperationCV)
        self.view.addSubview(deleteOperationButton)
        
        addOperationTypeSwitcher.easy.layout([
            Left(16),
            Right(16),
            Height(28),
            Top(24).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        let firstSectionHeight: CGFloat = 44 * 5
        let secondSectionHeight: CGFloat = 24 + 80
        let thirdSectionHeight: CGFloat = recordID != nil ? 0 : 24 + 52
        let cvHeight = firstSectionHeight + secondSectionHeight + thirdSectionHeight
        addOperationCV.easy.layout([
            Left(16),
            Right(16),
            recordID == nil ? Top(24).to(addOperationTypeSwitcher, .bottom) : Top(24).to(self.view.safeAreaLayoutGuide, .top),
            Height(cvHeight)
        ])
        
        deleteOperationButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addOperationCV, .bottom),
            Height(52)
        ])
    }
    
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = addOperationCV.cellForItem(at: indexPath) as? AddOperationCell {
            cell.updateSubMenuLabel(text)
        }
    }
    func updateDate(at indexPath: IndexPath, text: String) {
        if let cell = addOperationCV.cellForItem(at: indexPath) as? AddOperationCell {
            cell.dateTF.text = text
        }
    }
    func updateDescription(at indexPath: IndexPath, text: String) {
        if let cell = addOperationCV.cellForItem(at: indexPath) as? AddOperationCell {
            cell.operationDescriptionTF.text = text
        }
    }
    func updateAmount(at indexPath: IndexPath, text: String) {
        if let cell = addOperationCV.cellForItem(at: indexPath) as? AddOperationCell {
            cell.operationAmountTF.text = text
        }
    }

}
