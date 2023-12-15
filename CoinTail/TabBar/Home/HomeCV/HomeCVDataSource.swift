//
//  HomeCVDataSource.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit
import RealmSwift


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryIsHiddenDelegate, ArrowTapDelegate, SendCategoryCellDelegate, PushVC {

    // Скрытие / показ категорий при нажатии на диаграмму
    func categoryIsHidden(isHidden: Bool) {
        categoryIsHidden = isHidden
        
        homeGlobalCV.reloadData()
    }
    
    // Пролистывание круговой диаграммы
    func arrowTap(isLeft: Bool) {
        currentStep += isLeft ? 1 : -1
        
        sortOperations()
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
            
            cell.periodDelegate = self
            
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
            
            cell.categoryisHiddenDelegate = self
            cell.arrowTapDelegate = self
            cell.sendCategoryDelegate = self
            
            //TODO: сделать условие if userHasPremium
            cell.chartsUpdate(homeSegment, records: records)
            
            cell.categoriesArrCellData = HomeCategoryCell.packBins(data: categoriesByType).1
            
            let selectedCurrency = Currencies.shared.selectedCurrency.currency
            Records.shared.getAmount(
                for: period,
                type: homeSegment,
                step: currentStep,
                categoryID: categorySort?.id
            ) { amounts in
                DispatchQueue.main.async {
                    if let amounts = amounts {
                        // Отображаем сумму с ограничением до 2 знаков после запятой
                        let formattedAmount = String(format: "%.2f", amounts)
                        cell.amountForPeriodLabel.text = "\(formattedAmount) \(selectedCurrency)"
                    } else {
                        cell.amountForPeriodLabel.text = "0.00"
                    }
                }
            }
            cell.periodLabel.text = getPeriodLabel(step: currentStep)
            cell.category = categorySort
            
            let rightArrowIsHidden = currentStep == 0 || period == .allTheTime
            let leftArrowIsHidden = lastStep(
                for: Records.shared.records,
                categoryID: categorySort?.id
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

            cell.monthSectionsCellData = monthSections
            cell.pushVCDelegate = self

            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // Отступы по краям ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellIdentifier(for: IndexPath(row: 0, section: section)) {
        case HomeDateCell.id:
            return .init(top: 16, left: 0, bottom: 16, right: 0)
        case HomeCategoryCell.id:
            return .init(top: 0, left: 0, bottom: 16, right: 0)
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
                categoryIsHidden: categoryIsHidden,
                data: HomeCategoryCell.packBins(data: categoriesByType).0
            )
        case HomeOperationCell.id:
            return HomeOperationCell.size(data: monthSections)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    private func lastStep(for records: [RecordClass], categoryID: ObjectId? = nil) -> Int {
        var records = records
        
        if let category = categoryID {
            records = records.filter { $0.categoryID == category }
        }
        
        records.sort { l, r in
            return l.date < r.date
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
            let currentQuarter = (Int.norm(hi: currentYear, lo: currentMonth - 1, base: 12).nlo + 1) / 3
            let quarterCount = (currentYear - lastYear) * 4 + currentQuarter
                        
            return quarterCount
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
            let desiredQuarter = desiredMonth / 3
            let quarterText = "Quarter".localized()
            
            return "\(yearText) \(year), \(quarterText) \(desiredQuarter)"
        case .month:
            let year = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nhi
            let desiredMonth = Int.norm(hi: currentYear, lo: currentMonth - 1 - step, base: 12).nlo + 1
            let monthText = "Month".localized()
            
            return "\(yearText) \(year), \(monthText) \(desiredMonth)"
        }
    }
    
}
