//
//  SettingsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 23.10.23.
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
import StoreKit


extension SettingsVC {
    
    // Оценка приложения в AppStore
    func rateApp() {
        if let appID = Bundle.main.object(forInfoDictionaryKey: "ApplicationID") as? String {
            let url = "https://apps.apple.com/app/id\(appID)?action=write-review"

            guard let writeReviewURL = URL(string: url) else {
                SentryManager.shared.capture(error: "Invalid url for RateAlert", level: .error)
                
                return
            }
            
            UIApplication.shared.open(writeReviewURL)
        } else {
            SentryManager.shared.capture(error: "Not ApplicationID for RateAlert", level: .error)
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
    
    private func deleteConfirmationAlert(isFail: Bool = false) {
        let message = isFail ? "Failed to delete data - you entered an invalid line" : ""

        let alertController = UIAlertController(title: "Type 'Delete all data' to confirm the action".localized(), message: message, preferredStyle: .alert)

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
        // Удаляет пробелы в начале и в конце строки
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Делает проверку на совпадение текста с любым регистром
        if trimmedText.caseInsensitiveCompare("Delete all data".localized()) == .orderedSame {
            RealmService.shared.deleteAllData()
            
            self.selectedCurrency = Currencies.shared.selectedCurrency.currency
            Currencies.shared.createDefaultFavouriteCurrenciesIfNeeded()
            Categories.shared.createDefaultCategoriesIfNeeded()
            
            infoAlert("All data has been deleted!".localized(), "")
        } else {
            deleteConfirmationAlert(isFail: true)
        }
    }
    
}
