//
//  HomeVCActionFuncs.swift
//  CoinTail
//
//  Created by Eugene on 11.12.22.
//

import UIKit
import EasyPeasy


extension HomeViewController {
    
    // Переход на VC с добавлением операции
    @objc func AddNewOperation() {
        let vc = AddNewOperationVC(homeViewController: self, segmentIndex: switchButton.selectedSegmentIndex)
        vc.addNewOpDelegate = self // Связь с контроллером, откуда передаются данные
        
        vc.title = "Add a new operation"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func test() {
        print("aaa")
    }

    @objc func pieChartAction() {
        let pieChartVC = PieChartViewController(homeViewController: self, segmentIndex: switchButton.selectedSegmentIndex)
        
        print("segmentType HomeVC: \(self.currentSegmentType.rawValue)")
        
        pieChartDelegate?.sendNewOperation(switchButtonValue: self.currentSegmentType.rawValue)
        
        self.present(pieChartVC, animated: true, completion: nil)
    }
    
    @objc func switchButtonAction(target: UISegmentedControl) {
        print("cellArr: \(Storage.shared.records[currentSegmentType]!)")
        
        setEmptyOperationsLabel()
        
        tableView.reloadData()
    }
    
}
