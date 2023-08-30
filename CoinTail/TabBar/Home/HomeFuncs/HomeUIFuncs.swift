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
            action: #selector (addNewOperationAction)
        )
    }
    
    func filterMonths() {
        let getRecord = Records.shared.getRecords(for: period, type: homeSegment, step: currentStep, category: categorySort)
        
        Categories.shared.categoriesUpdate(records: getRecord)
        
        categoriesByType = Categories.shared.getCategories(for: homeSegment)
        monthSections = MonthSection.groupRecords(section: homeSegment, groupRecords: getRecord)
        
        let totalBalance = "Total balance:".localized()
        balanceLabel.text = "\(totalBalance) $\(Records.shared.getAmount(for: .allTheTime, type: .allOperations))"
    
        // Отсортировать массив операций по месяцам (убывание)
        monthSections.sort { l, r in
            return l.month > r.month
        }
    }


}
