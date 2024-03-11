//
//  HomeCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
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
import RealmSwift


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryIsHiddenDelegate, ArrowTapDelegate, SendCategoryCellDelegate, ShowChartsAlertDelegate, PushVC {
    
    func showAlert(message: String) {
        self.infoAlert(message)
    }

    // Скрытие / показ категорий при нажатии на диаграмму
    func categoryIsHidden(isHidden: Bool) {
        categoryIsHidden = isHidden
        
        homeGlobalCV.reloadData()
    }
    
    // Пролистывание круговой диаграммы
    func arrowTap(isLeft: Bool) {
        currentStep += isLeft ? 1 : -1
        self.isLeft = isLeft
        
        sortOperations(isArrow: true)
    }
    
    // При нажатии на категорию помечает ее выбранной в коллекции
    func sendCategory(category: CategoryClass) {
        categorySort = categorySort == category ? nil : category
        
        sortOperations()
    }
    
    // Переход на контроллер для редактирования операции
    func pushVC(record: RecordClass) {
        self.navigationItem.rightBarButtonItem?.target = nil
                
        let vc = AddOperationVC(operationID: record.id)
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        navigationController?.pushViewController(vc, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [self] in
            categorySort = nil
        }
    }
    func pushVC() {
        self.navigationItem.rightBarButtonItem?.target = nil
        
        let vc = AddOperationVC(segmentIndex: segmentIndex - 1)
        vc.hidesBottomBarWhenPushed = true

        navigationController?.pushViewController(vc, animated: true)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // Возвращается id ячейки по секции
    private func cellIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return HomeDateCell.id
        case 1:
            return HomeCategoryCell.id
        case 2:
            return HomeOperationCell.id
        default:
            return ""
        }
    }

    // Заполнение ячеек по их id.
    // Каждой ячейке соответствует свой массив, данные которого берутся из HomeVC
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellIdentifier(for: indexPath) {
        case HomeDateCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeDateCell.id,
                for: indexPath
            ) as? HomeDateCell else {
                return UICollectionViewCell()
            }
            
            cell.segmentDateDelegate = self
            
            cell.period = period
                        
            return cell
        case HomeCategoryCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeCategoryCell.id,
                for: indexPath
            ) as? HomeCategoryCell else {
                return UICollectionViewCell()
            }
            
            let records = Records.shared.getRecords(
                for: period,
                type: homeSegment,
                step: currentStep,
                categoryID: categorySort?.id
            )
            
            // Обновляет categoryIsHidden при переключении свичера, если операции в каком-либо типе отсутствуют
            categoryIsHidden = monthSections.isEmpty ? true : categoryIsHidden
            
            cell.categoryisHiddenDelegate = self
            cell.arrowTapDelegate = self
            cell.sendCategoryDelegate = self
            cell.sendAlertDelegate = self
            
            cell.chartsUpdate(homeSegment, records: records)
            cell.segmentType = homeSegment
            cell.categoriesArrCellData = HomeCategoryCell.packBins(data: categoriesByType).1
            
            let selectedCurrency = Currencies.shared.selectedCurrency.currency
            Records.shared.getAmount(
                for: period,
                type: homeSegment,
                step: currentStep,
                categoryID: categorySort?.id
            ) { amounts in
                if let amounts = amounts {
                    // Отображаем сумму с ограничением до 2 знаков после запятой
                    let formattedAmount = String(format: "%.2f", amounts)
                    cell.amountForPeriodLabel.text = "\(formattedAmount) \(selectedCurrency)"
                } else {
                    cell.amountForPeriodLabel.text = "0.00"
                }
            }
            cell.periodLabel.text = getPeriodLabel(step: currentStep)
            cell.category = categorySort
            
            let rightArrowIsHidden = borderStep(
                for: Records.shared.records,
                categoryID: categorySort?.id,
                isLeft: false
            ) == currentStep || period == .allTheTime
            let leftArrowIsHidden = borderStep(
                for: Records.shared.records,
                categoryID: categorySort?.id,
                isLeft: true
            ) == currentStep || period == .allTheTime
            
            cell.arrowIsHidden(left: leftArrowIsHidden, right: rightArrowIsHidden)
                                    
            return cell
        case HomeOperationCell.id:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeOperationCell.id,
                for: indexPath
            ) as? HomeOperationCell else {
                return UICollectionViewCell()
            }

            cell.segmentType = homeSegment
            cell.monthSectionsCellData = monthSections
            cell.pushVCDelegate = self
            cell.noOperationsByType()

            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // Отступы по краям ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case HomeDateCell.id:
            return .init(top: 16, left: 0, bottom: 0, right: 0)
        case HomeCategoryCell.id:
            return .init(top: 16, left: 0, bottom: 16, right: 0)
        case HomeOperationCell.id:
            return .init(top: 0, left: 0, bottom: 16, right: 0)
        default:
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    // Динамические размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellIdentifier(for: indexPath) {
        case HomeDateCell.id:
            return HomeDateCell.size()
        case HomeCategoryCell.id:
            return HomeCategoryCell.size(
                categoryIsHidden: monthSections.isEmpty ? true : categoryIsHidden,
                data: HomeCategoryCell.packBins(data: categoriesByType).0
            )
        case HomeOperationCell.id:
            return HomeOperationCell.size(data: monthSections)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func borderStep(for records: [RecordClass], categoryID: ObjectId? = nil, isLeft: Bool) -> Int {
        var records = records.filter {
            switch homeSegment {
            case .allOperations:
                return true
            case .expense:
                return $0.type == RecordType.expense.rawValue
            case .income:
                return $0.type == RecordType.income.rawValue
            }
        }
        
        if let category = categoryID {
            records = records.filter { $0.categoryID == category }
        }
        
        records.sort { l, r in
            if isLeft {
                return l.date < r.date
            } else {
                return l.date > r.date
            }
        }
        
        guard let date = records.first?.date else { return 0 }

        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        let lastMonth = Calendar.current.component(.month, from: date)
        let lastYear = Calendar.current.component(.year, from: date)
                
        switch period {
        case .allTheTime:
            return 0
        case .year:
            return currentYear - lastYear
        case .quarter:
            let monthCount = currentMonth - lastMonth + (currentYear - lastYear) * 12
                        
            return Int(ceil(Double(monthCount) / 3.0))
        case .month:
            let monthCount = currentMonth - lastMonth + (currentYear - lastYear) * 12
                        
            return monthCount
        }
    }
    
    private func getPeriodLabel(step: Int = 0) -> String {
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        let yearText = "Year".localized()
                
        switch period {
        case .allTheTime:
            return "All the time".localized()
        case .year:
            return "\(yearText) \(currentYear - step)"
        case .quarter:
            let year = Int.norm(hi: currentYear, lo: currentMonth - 1 - step * 3, base: 12).nhi
            let desiredMonth = Int.norm(hi: currentYear, lo: currentMonth - 1 - step * 3, base: 12).nlo + 1
            let desiredQuarter = desiredMonth / 3 + 1
            let quarterText = "Q".localized()
            
            return "\(yearText) \(year), \(quarterText)-\(desiredQuarter)"
        case .month:
            let year = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nhi
            let desiredMonth = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nlo + 1
            
            let monthText = monthName(monthNumber: desiredMonth)
            
            return "\(yearText) \(year), \(monthText)"
        }
    }
    
    private func monthName(monthNumber: Int) -> String {
        switch monthNumber {
        case 1:
            return "January".localized()
        case 2:
            return "February".localized()
        case 3:
            return "March".localized()
        case 4:
            return "April".localized()
        case 5:
            return "May".localized()
        case 6:
            return "June".localized()
        case 7:
            return "July".localized()
        case 8:
            return "August".localized()
        case 9:
            return "September".localized()
        case 10:
            return "October".localized()
        case 11:
            return "November".localized()
        case 12:
            return "December".localized()
        default:
            return "Month".localized() + " \(monthNumber)"
        }
    }
    
}
