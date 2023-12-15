//
//  AddOperationUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


extension AddOperationVC: UIScrollViewDelegate {
    
    func setupUI(with record: RecordClass) {    
        deleteOperationButton.isHidden = false
        
        // Дата
        operationDate = record.date

        guard let recordType = RecordType(rawValue: record.type) else { return }

        // Тип операции
        addOperationSegment = recordType
        addOperationTypeSwitcher.selectedSegmentIndex = addOperationSegment == .income ? 0 : 1
        addOperationTypeSwitcher.isHidden = true

        // Сумма
        operationAmount = "\(record.amount)"
        
        // Описание
        operationDescription = record.descriptionText

        // Категория
        self.categoryID = record.categoryID
        guard let category = Categories.shared.getGeneralCategory(for: record.categoryID) else { return }
        operationCategory = category.name
        
        // Счет
        if let accountID = record.accountID, let account = Accounts.shared.getAccount(for: accountID) {
            selectedAccount = account.name
        }
        
        selectedCurrency = record.currency
    }
    
    func addOperationNavBar() {
        let title = recordID != nil ? "Edit".localized() : "Save".localized()

        let saveButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(saveButtonAction))
            
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
