//
//  AddNewOperationActions.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit


extension AddNewOperationVC {
    
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func saveButtonAction() {
        
    }
    
    @objc func categoryButtonAction() {
        
        guard let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex) else { return }
        
        var categories = [String]()
        
        switch segment {
            case "Expense":
                categories = ["Taxi", "Glocery", "Clothing", "Gym", "Service", "Subscription", "Health"]
            case "Income":
                categories = ["Salary", "Debt repayment", "Side job"]
            default:
                fatalError("undefined segment")
        }
                        
        let vc = AddNewOperationPopVC(categories)
        vc.categoryDelegate = self // Связь с контроллером, откуда передаются данные
        present(vc, animated: true, completion: nil) // Всплытие PopVC
    }
    
    @objc func switchButtonAction(target: UISegmentedControl) {
        let segmentTitle = target.titleForSegment(at: target.selectedSegmentIndex)!
        print("changed segment => \(segmentTitle)")
    }
}
