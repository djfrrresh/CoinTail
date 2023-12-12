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
        self.view.addSubview(homeTypeSwitcher)
        self.view.addSubview(balanceLabel)
        self.view.addSubview(homeGlobalCV)
        
        homeTypeSwitcher.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        balanceLabel.easy.layout([
            CenterX(),
            Top(-30).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        homeGlobalCV.easy.layout([
            Left(),
            Right(),
            Bottom(),
            Top(16).to(homeTypeSwitcher, .bottom)
        ])
    }
    
    func isOperationsEmpty() {
        let isEmpty = monthSections.isEmpty
        
        operationsImageView.isHidden = !isEmpty
        noOperationsLabel.isHidden = !isEmpty
        operationsDescriptionLabel.isHidden = !isEmpty
        addOperationButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        homeTypeSwitcher.isHidden = isEmpty
        homeGlobalCV.isHidden = isEmpty
        balanceLabel.isHidden = isEmpty
        
        if isEmpty {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(goToAddOperationVC)
            )
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
        
        let totalBalanceText = "Balance:".localized()
        let currency = Currencies.shared.selectedCurrency.currency
        
        Records.shared.getAmount(for: .allTheTime, type: .allOperations) { amounts in
            DispatchQueue.main.async { [self] in
                if let amounts = amounts {
                    // Отображаем сумму с ограничением до 2 знаков после запятой
                    let formattedAmount = String(format: "%.2f", amounts)
                    balanceLabel.text = "\(totalBalanceText) \(formattedAmount) \(currency)"
                } else {
                    balanceLabel.text = "\(totalBalanceText) 0 \(currency)"
                }
            }
        }
                
        // Отсортировать операции по месяцам (убывание)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }

}
