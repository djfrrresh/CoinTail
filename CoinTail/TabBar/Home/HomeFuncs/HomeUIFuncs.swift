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
    
    // Кнопки "Добавить" и "Поиск" в навигейшен баре
    func homeNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector (goToAddOperationVC)
        )
    }
    
    func sortRecords() {
        let getRecord = Records.shared.getRecords(
            for: period,
            type: homeSegment,
            step: currentStep,
            category: categorySort
        )
        
        // Обновление категорий
        Categories.shared.categoriesUpdate(records: getRecord)
        categoriesByType = Categories.shared.getCategories(for: homeSegment)
        // Группировка записей
        monthSections = MonthSection.groupRecords(section: homeSegment, groupRecords: getRecord)
        
        // Вычисление общего баланса
        let totalBalance = "Total balance:".localized()
        let allTimeAmount = Records.shared.getAmount(for: .allTheTime, type: .allOperations)
        balanceLabel.text = "\(totalBalance) $\(allTimeAmount)"
        
        // Отсортировать операции по месяцам (убывание)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }

}
