//
//  HomeUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 18.05.23.
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
import EasyPeasy


extension HomeVC: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is HomeVC {
            navigationController.setNavigationBarHidden(true, animated: animated)
        } else {
            navigationController.setNavigationBarHidden(false, animated: animated)
        }
    }
    
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
        
        operationsEmojiLabel.isHidden = !isEmpty
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
                    SentryManager.shared.capture(error: "Empty amount in HomeVC", level: .error)
                    print("Failed to calculate amount.")
                    self.customNavBar.titleLabel.text = "0.00 \(currency)"
                }
            }
        }
    }
    
    func sortOperations(isArrow: Bool = false) {
        let getRecord = Records.shared.getRecords(
            for: period,
            type: homeSegment,
            step: currentStep,
            categoryID: categorySort?.id
        )
        
        if isArrow {
            guard !getRecord.isEmpty else {
                currentStep = isLeft ? currentStep + 1 : currentStep - 1
                sortOperations(isArrow: true)
                                
                return
            }
        }
        
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
