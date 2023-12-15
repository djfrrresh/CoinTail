//
//  SettingsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 23.10.23.
//

import UIKit
import StoreKit


extension SettingsVC {
    
    // Оценка приложения в AppStore
    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func deleteData() {
        confirmationAlert(
            title: "Delete data".localized(),
            message: "Are you sure you want to delete all data: transactions, budgets, accounts?".localized(),
            confirmActionTitle: "Confirm".localized(),
            confirmActionHandler: {
                self.deleteConfirmationAlert()
            }
        )
    }
    
    private func deleteConfirmationAlert() {
        let alertController = UIAlertController(title: "Type 'Delete all data' to confirm the action".localized(), message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Delete all data".localized()
        }

        let doneAction = UIAlertAction(title: "Delete".localized(), style: .destructive) { [weak self] _ in
            guard let textField = alertController.textFields?.first else { return }
            let enteredText = textField.text ?? ""
            
            self?.handleTextEntered(enteredText)
        }
        alertController.addAction(doneAction)

        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    private func handleTextEntered(_ text: String) {
        if text == "Delete all data".localized() {
            RealmService.shared.deleteAllData()
            self.selectedCurrency = Currencies.shared.selectedCurrency.currency
            
            infoAlert("All data has been deleted!".localized(), "")
        } else {
            infoAlert("Failed to delete data - you entered an invalid line".localized())
        }
    }
    
}
