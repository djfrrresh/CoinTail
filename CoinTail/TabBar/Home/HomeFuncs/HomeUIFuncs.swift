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
        
        sortRecords()
    }
    
    static func getNoOperationsLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Start adding your expenses and income".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        
        return label
    }
    
    static func getOperationsDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Manage your finances by tracking your expenses and income via different categories".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }
    
    func emptyOperationsSubviews() {
        self.view.addSubview(emptyOperationsView)
        
        emptyOperationsView.easy.layout([
            Left(16),
            Right(16),
            Center(),
            Height(BudgetsVC.noDataViewSize(
                noDataLabel: HomeVC.getNoOperationsLabel(),
                descriptionLabel: HomeVC.getOperationsDescriptionLabel()
            ))
        ])

        emptyOperationsView.addSubview(graphicsImageView)
        emptyOperationsView.addSubview(noOperationsLabel)
        emptyOperationsView.addSubview(operationsDescriptionLabel)
        emptyOperationsView.addSubview(addOperationButton)
        
        graphicsImageView.easy.layout([
            Height(100),
            Width(100),
            Top(),
            CenterX()
        ])
        
        noOperationsLabel.easy.layout([
            Left(),
            Right(),
            Top(32).to(graphicsImageView, .bottom)
        ])
        
        operationsDescriptionLabel.easy.layout([
            Left(),
            Right(),
            Top(16).to(noOperationsLabel, .bottom)
        ])

        addOperationButton.easy.layout([
            Height(52),
            Left(),
            Right(),
            CenterX(),
            Top(16).to(operationsDescriptionLabel, .bottom),
            Bottom()
        ])
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
        
        graphicsImageView.isHidden = !isEmpty
        noOperationsLabel.isHidden = !isEmpty
        operationsDescriptionLabel.isHidden = !isEmpty
        addOperationButton.isHidden = !isEmpty
        emptyOperationsView.isHidden = !isEmpty
        
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
    
    func sortRecords() {
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
        
        // Вычисление общего баланса
        let totalBalance = "Balance:".localized()
        let allTimeAmount = Records.shared.getAmount(for: .allTheTime, type: .allOperations)
        let currency = Currencies.shared.selectedCurrency.currency
        
        balanceLabel.text = "\(totalBalance) \(allTimeAmount) \(currency)"
        
        // Отсортировать операции по месяцам (убывание)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }

}
