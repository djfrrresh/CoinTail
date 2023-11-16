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
        addOperationCV.easy.layout([
            Top(32).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
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
        if let categoryName = Categories.shared.getCategory(for: record.categoryID)?.name {
            operationCategory = categoryName
        }
        categoryID = record.categoryID

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
        self.view.addSubview(addOperationPickerView)
        self.view.addSubview(toolBar)
        
        addOperationTypeSwitcher.easy.layout([
            Left(16),
            Right(16),
            Height(28),
            Top(24).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        addOperationCV.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addOperationTypeSwitcher, .bottom),
            Height(44 * 5 + 24 + 80)
        ])
        
        deleteOperationButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(addOperationCV, .bottom),
            Height(52)
        ])
        
        addOperationPickerView.easy.layout([
            Left(),
            Right(),
            Height(200),
            Bottom().to(self.view.safeAreaLayoutGuide, .bottom)
        ])
        
        toolBar.easy.layout([
            Left(),
            Right(),
            Height(44),
            Bottom().to(addOperationPickerView, .top)
        ])
    }
    
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = addOperationCV.cellForItem(at: indexPath) as? AddOperationCell {
            cell.updateSubMenuLabel(text)
        }
    }
    func updateDescription(at indexPath: IndexPath, text: String) {
        if let cell = addOperationCV.cellForItem(at: indexPath) as? AddOperationCell {
            cell.operationDescriptionTF.text = text
        }
    }
    
    func setupToolBar() {
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonAction)
        )

        toolBar.setItems([doneButton], animated: true)
    }

}
