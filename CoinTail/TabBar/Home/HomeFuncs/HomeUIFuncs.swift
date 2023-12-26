//
//  HomeUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 18.05.23.
//

import UIKit
import EasyPeasy


extension HomeVC {
    
    func homeSubviews() {
        self.view.addSubview(customNavBar)
        self.view.addSubview(homeGlobalCV)
        
        customNavBar.easy.layout([
            Height(96),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Left(),
            Right()
        ])
        
        homeGlobalCV.easy.layout([
            Left(),
            Right(),
            Bottom(),
            Top().to(customNavBar, .bottom)
        ])
    }
    
    func areOperationsEmpty() {
        let isEmpty = RealmService.shared.recordsArr.isEmpty
        
        operationsImageView.isHidden = !isEmpty
        noOperationsLabel.isHidden = !isEmpty
        operationsDescriptionLabel.isHidden = !isEmpty
        addOperationButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        homeGlobalCV.isHidden = isEmpty
    }
    
    func updateBalanceLabel() {
        DispatchQueue.main.async {
            let currency = Currencies.shared.selectedCurrency.currency
            
            Records.shared.getAmount(for: .allTheTime, type: .allOperations) { amounts in
                if let amounts = amounts {
                    // Отображаем сумму с ограничением до 2 знаков после запятой
                    let formattedAmount = String(format: "%.2f", amounts)
                    self.customNavBar.titleLabel.text = "\(formattedAmount) \(currency)"
                } else {
                    self.customNavBar.titleLabel.text = "0.00 \(currency)"
                }
            }
        }
    }
    
    func sortOperations() {
        let getRecord = Records.shared.getRecords(
            for: period,
            type: homeSegment,
            step: currentStep,
            categoryID: categorySort?.id
        )
        
        // Обновление категорий
        Categories.shared.categoriesUpdate(records: getRecord)
        categoriesByType = Categories.shared.getCategories(for: homeSegment)
        // Группировка записей
        monthSections = OperationsDaySection.groupRecords(section: homeSegment, groupRecords: getRecord)
        
        updateBalanceLabel()
                
        // Отсортировать операции по месяцам (убывание)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }

}
