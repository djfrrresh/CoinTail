//
//  AddBudgetActions.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


extension AddBudgetVC {
    
    @objc func saveBudgetAction() {
        guard let amountText = budgetAmount,
              let amount = Double(amountText),
              let categoryText = budgetCategory else { return }
                
        budgetValidation(amount: amount, categoryText: categoryText) { [weak self] amount, categoryID in
            guard let strongSelf = self else { return }
            
            var startDate, untilDate: Date
            
            if let budgetID = strongSelf.budgetID, let budget = Budgets.shared.getBudget(for: budgetID) {
                startDate = budget.startDate
                untilDate = budget.untilDate
            } else {
                startDate = Date()
                untilDate = strongSelf.budgetDateUntil()
            }
            
            let currency = strongSelf.selectedCurrency
            
            let budget = BudgetClass()
            budget.categoryID = categoryID
            budget.amount = amount
            budget.startDate = startDate
            budget.untilDate = untilDate
            budget.currency = "\(currency)"
            
            if let budgetID = strongSelf.budgetID {
                budget.id = budgetID

                Budgets.shared.editBudget(replacingBudget: budget)
            } else {
                Budgets.shared.addBudget(budget)
            }
            
            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func goToSelectCategoryVC() {
        // Передаем название и иконки категорий по типу операций
        let vc = SelectCategoryVC(segmentTitle: "Expense", isParental: true)
        vc.categoryDelegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
        toolBar.isHidden = true
        currenciesPickerView.isHidden = true
    }
    
    func goToBudgetPeriodVC() {
        let vc = BudgetPeriodVC(period: budgetTimePeriod)
        vc.regulatiryDelegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
        toolBar.isHidden = true
        currenciesPickerView.isHidden = true
    }
    
    @objc func removeBudget(_ sender: UIButton) {
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
    
    private func budgetDateUntil() -> Date {
        var daysToAdd: Int
        
        switch budgetTimePeriod {
        case "Week":
            daysToAdd = 7
        case "Month":
            daysToAdd = 30
        default:
            daysToAdd = 30
        }
        
        let dateComponents: DateComponents = {
            var components = DateComponents()
            components.day = daysToAdd
            
            return components
        }()
        let currentDate = Date()
        let futureDate = Calendar.current.date(byAdding: dateComponents, to: currentDate) ?? currentDate
        
        return futureDate
    }
    
    @objc func doneButtonAction() {
        toolBar.isHidden = true
        currenciesPickerView.isHidden = true
    }
    
}
