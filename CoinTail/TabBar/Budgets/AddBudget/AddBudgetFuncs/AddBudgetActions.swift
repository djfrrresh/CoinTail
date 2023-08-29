//
//  AddBudgetActions.swift
//  CoinTail
//
//  Created by Eugene on 03.07.23.
//

import UIKit


extension AddBudgetVC {
    
    @objc func saveBudgetAction() {
        let amount = Double(budgetAmountTF.text ?? "0") ?? 0
        let categoryText = categoryButton.titleLabel?.text ?? AddBudgetVC.defaultCategory
        let isEditing = budgetID != nil ? true : false
        
        budgetValidation(amount: amount, categoryText: categoryText, isEditingBudget: isEditing) { [weak self] amount, category in
            guard let strongSelf = self else { return }
            
            var startDate: Date = Date()
            var untilDate: Date = strongSelf.budgetDateUntil()

            if let budgetID = strongSelf.budgetID {
                startDate = Budgets.shared.getBudget(for: budgetID)?.startDate ?? startDate
                untilDate = Budgets.shared.getBudget(for: budgetID)?.untilDate ?? untilDate
            }
            
            let budget = Budget(
                category: category,
                amount: amount,
                startDate: startDate,
                untilDate: untilDate,
                id: Budgets.shared.budgetID
            )
            Budgets.shared.budgetID += 1
                   
            strongSelf.saveBudgetButton.removeTarget(nil, action: nil, for: .allEvents)

            if let budgetID = strongSelf.budgetID {
                Budgets.shared.editBudget(for: budgetID, replacingBudget: budget)
            } else {
                Budgets.shared.addNewBudget(budget: budget)
            }
            
            strongSelf.navigationController?.popToRootViewController(animated: true)
        }        
    }
    
    @objc func selectCategoryAction() {
        saveBudgetButton.removeTarget(nil, action: nil, for: .allEvents)
        categoryButton.removeTarget(nil, action: nil, for: .allEvents)
        
        // Передаем название и иконки категорий по типу операций
        let vc = SelectCategoryVC(segmentTitle: "Expense")

        vc.categoryDelegate = self
        
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func removeBudget() {
        guard let id = budgetID else { return }
        
        let confirmAction = UIAlertAction(title: "Confirm".localized(), style: .default) { [weak self] _ in
            Budgets.shared.deleteBudget(for: id)
            self?.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        let alertView = UIAlertController(title: "Delete operation".localized(), message: "Are you sure?".localized(), preferredStyle: .alert)
        
        alertView.addAction(confirmAction)
        alertView.addAction(cancelAction)

        self.present(alertView, animated: true)
    }
    
    // 
    private func budgetDateUntil() -> Date {
        var daysToAdd: Int
        
        switch periodSwitcher.selectedSegmentIndex {
        case 0:
            daysToAdd = 7
        case 1:
            daysToAdd = 30
        default:
            fatalError("no segment")
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
    
}
