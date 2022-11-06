//
//  AddNewOperationActions.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit


extension AddNewOperationVC {
    
    // Для кнопки с датой
//    @objc func createToolbarAction() -> UIToolbar { // Всплывающий снизу DatePicker
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
//        toolbar.setItems([doneButton], animated: true)
//
//        return toolbar
//    }
    
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        // Для кнопки с датой
//        self.dateButton.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
        @objc func saveButtonAction(sender: AnyObject) {
            let amount = Double(amountTextField.text!)
            if ((amount != 0.00 && (amount != nil)) && categoryButton.titleLabel!.text! != "Select category") {
                addNewOpDelegate?.sendAmount(amountText: self.amountTextField.text!)
                addNewOpDelegate?.sendDescription(descriptionText: self.descriptionTextField.text!)
                addNewOpDelegate?.sendCategoryButtonText(categoryText: self.categoryButton.titleLabel!.text!)
                addNewOpDelegate?.sendDate(dateText: self.dateTextField.text!)
                addNewOpDelegate?.sendCategoryImage(categoryImage: self.categoryImage)
                
                homeViewController.addRowToEnd() // homeViewController ссылается на функцию addRowToEnd
                // Если написать HomeViewController().addRowToEnd(), то я создам новый объект
                // Теперь я обращаюсь к старому объекту (функции)
                
                self.navigationController?.popToRootViewController(animated: true) // Закрыть AddNewOperationVC
            } else {
                print ("error")
            }
    }
    
    @objc func categoryButtonAction() {
        
        guard let segment = switchButton.titleForSegment(at: switchButton.selectedSegmentIndex) else { return }
        
        var categories = [String]()
        var categoryImages = [String]()
        
        switch segment {
            case "Expense":
            
                categories = ["Taxi", "Glocery", "Clothing", "Gym", "Service", "Subscription", "Health", "Cafe"]
                categoryImages = ["car.circle", "cart.circle", "tshirt", "figure.walk.circle", "gearshape.circle", "gamecontroller", "heart.circle", "fork.knife.circle"]
            case "Income":
                categories = ["Salary", "Debt repayment", "Side job"]
                categoryImages = ["dollarsign.circle", "creditcard.circle", "briefcase.circle"]
            default:
                fatalError("undefined segment")
        }
                    
        let vc = AddNewOperationPopVC(categories, categoryImages)
        vc.categoryDelegate = self // Связь с контроллером, откуда передаются данные
        present(vc, animated: true, completion: nil) // Всплытие PopVC
    }
    
    @objc func switchButtonAction(target: UISegmentedControl) {
        let segmentTitle = target.titleForSegment(at: target.selectedSegmentIndex)!
        print("changed segment => \(segmentTitle)")
    }
}
