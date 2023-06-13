//
//  HomeActions.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeVC {
    
    @objc func addNewOperationAction() {
        print("addNewOperationAction")
    }
    
    @objc func searchBarAction() {
        print("searchBarAction")
    }
    
    @objc func switchAction() {
        // Обновление сегмента
        segment = RecordType(rawValue: typeSwitcher.titleForSegment(at: typeSwitcher.selectedSegmentIndex) ?? "Total") ?? .allOperations
        
        filterMonths() // Сортировка коллекции с операциями
        setEntries() // Добавление записей в диаграммы
    }
    
}
