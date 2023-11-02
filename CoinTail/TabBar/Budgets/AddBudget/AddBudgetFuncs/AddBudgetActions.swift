//
//  AddBudgetActions.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


extension AddBudgetVC {
    
    @objc func saveBudgetAction() {
//        guard let amountText = budgetAmountTF.text,
//              let amount = Double(amountText),
//              let currencyText = currencyButton.titleLabel?.text else { return }
//        
//        let categoryText = categoryButton.titleLabel?.text ?? AddBudgetVC.defaultCategory
//        let isEditing = budgetID != nil
//        
//        budgetValidation(amount: amount, categoryText: categoryText, isEditingBudget: isEditing) { [weak self] amount, categoryID in
//            guard let strongSelf = self else { return }
//            
//            var startDate, untilDate: Date
//            
//            if let budgetID = strongSelf.budgetID, let budget = Budgets.shared.getBudget(for: budgetID) {
//                startDate = budget.startDate
//                untilDate = budget.untilDate
//            } else {
//                startDate = Date()
//                untilDate = strongSelf.budgetDateUntil()
//            }
//            
//            strongSelf.setCurrency(currencyCode: currencyText)
//            let currency = strongSelf.currency
//            
//            let budget = BudgetClass()
//            budget.categoryID = categoryID
//            budget.amount = amount
//            budget.startDate = startDate
//            budget.untilDate = untilDate
//            budget.currency = "\(currency)"
//            
//            if let budgetID = strongSelf.budgetID {
//                budget.id = budgetID
//            }
//            
//            strongSelf.saveBudgetButton.removeTarget(nil, action: nil, for: .allEvents)
//
//            if strongSelf.budgetID != nil {
//                Budgets.shared.editBudget(replacingBudget: budget)
//            } else {
//                Budgets.shared.addBudget(budget)
//            }
//            
//            strongSelf.navigationController?.popToRootViewController(animated: true)
//        }        
    }
    
    func goToSelectCategoryVC() {
        // Передаем название и иконки категорий по типу операций
        let vc = SelectCategoryVC(segmentTitle: "Expense", isParental: true)
        vc.categoryDelegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToBudgetPeriodVC() {
        let vc = BudgetPeriodVC()
//        vc.budgetPeriodDelegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func removeBudget() {
        guard let id = budgetID else { return }

        confirmationAlert(
            title: "Delete budget".localized(),
            message: "Are you sure?".localized(),
            confirmActionTitle: "Confirm".localized()
        ) { [weak self] in
            Budgets.shared.deleteBudget(for: id)
            
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
//    private func budgetDateUntil() -> Date {
//        var daysToAdd: Int
//        
//        switch periodSwitcher.selectedSegmentIndex {
//        case 0:
//            daysToAdd = 7
//        case 1:
//            daysToAdd = 30
//        default:
//            fatalError("no segment")
//        }
//        
//        let dateComponents: DateComponents = {
//            var components = DateComponents()
//            components.day = daysToAdd
//            
//            return components
//        }()
//        let currentDate = Date()
//        let futureDate = Calendar.current.date(byAdding: dateComponents, to: currentDate) ?? currentDate
//        
//        return futureDate
//    }
    
    @objc func doneButtonAction() {
        toolBar.isHidden = true
        currenciesPickerView.isHidden = true
    }
    
}
