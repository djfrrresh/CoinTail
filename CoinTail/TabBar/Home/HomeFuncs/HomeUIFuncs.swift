//
//  HomeUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 18.05.23.
//

import UIKit
import EasyPeasy


extension HomeVC: SelectedDate {
    
    // Передает выбранный период и обнуляет счетчик шагов для диаграммы
    func selectedPeriod(_ period: DatePeriods) {
        self.period = period
        currentStep = 0
        
        sortOperations()
    }
    
    func homeSubviews() {
        self.view.addSubview(customNavBar)
        self.view.addSubview(homeTypeSwitcher)
        self.view.addSubview(homeGlobalCV)
        
        customNavBar.easy.layout([
            Height(96),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Left(),
            Right()
        ])
        
        homeTypeSwitcher.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(customNavBar, .bottom)
        ])
        
        homeGlobalCV.easy.layout([
            Left(),
            Right(),
            Bottom(),
            Top().to(homeTypeSwitcher, .bottom)
        ])
    }
    
    func areOperationsEmpty() {
        let isEmpty = monthSections.isEmpty
        
        operationsImageView.isHidden = !isEmpty
        noOperationsLabel.isHidden = !isEmpty
        operationsDescriptionLabel.isHidden = !isEmpty
        addOperationButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        homeTypeSwitcher.isHidden = isEmpty
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
