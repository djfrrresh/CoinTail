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
            title: "Delete data",
            message: "Are you sure you want to delete all information: operations, budgets, accounts?".localized(),
            confirmActionTitle: "Confirm".localized(),
            confirmActionHandler: {
                RealmService.shared.deleteAllData()
                self.selectedCurrency = Currencies.shared.selectedCurrency.currency
            }
        )
    }
    
}
