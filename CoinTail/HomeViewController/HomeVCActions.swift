//
//  HomeVCActionFuncs.swift
//  CoinTail
//
//  Created by Eugene on 11.12.22.
//

import UIKit


extension HomeViewController {
    
    // Переход на VC с добавлением операции
    @objc func AddNewOperation() {
        let vc = AddNewOperationVC(homeViewController: self, segmentIndex: switchButton.selectedSegmentIndex)
        vc.addNewOpDelegate = self // Связь с контроллером, откуда передаются данные
        
        vc.title = "Add a new operation"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func switchButtonAction(target: UISegmentedControl) {
        print("cellArr: \(Storage.shared.records[currentSegmentType]!)")
        tableView.reloadData()
        setChart()
    }
    
}
