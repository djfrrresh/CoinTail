//
//  HomeActions.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeVC {
    
    @objc func addNewOperationAction() {
        var segmentIndex = homeTypeSwitcher.selectedSegmentIndex
        
        segmentIndex = segmentIndex == 0 ? 0 : segmentIndex - 1
        
        let vc = AddOperationVC(segmentIndex: segmentIndex)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchBarAction() {
        print("searchBarAction")
    }
    
    @objc func switchAction() {
        // Обновление сегмента
        homeSegment = RecordType(rawValue: homeTypeSwitcher.titleForSegment(at: homeTypeSwitcher.selectedSegmentIndex) ?? "Total") ?? .allOperations
        
        filterMonths() // Сортировка коллекции с операциями
    }
    
}
