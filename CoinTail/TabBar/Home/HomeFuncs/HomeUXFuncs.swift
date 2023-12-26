//
//  HomeUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 18.05.23.
//

import UIKit


extension HomeVC: SelectedSegmentDate {
    
    func sendSegment(_ segment: RecordType, index: Int) {
        segmentIndex = index
        homeSegment = segment
        categorySort = nil
        sortOperations() // Сортировка коллекции с операциями
    }
    
    // Передает выбранный период и обнуляет счетчик шагов для диаграммы
    func selectedPeriod(_ period: DatePeriods) {
        self.period = period
        currentStep = 0
        
        sortOperations()
    }
        
    func homeButtonTargets() {
        addOperationButton.addTarget(self, action: #selector(goToAddOperationVC), for: .touchUpInside)
        customNavBar.customButton.addTarget(self, action: #selector(goToAddOperationVC), for: .touchUpInside)
    }
        
}
