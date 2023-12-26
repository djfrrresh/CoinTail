//
//  HomeActions.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit


extension HomeVC {
    
    @objc func goToAddOperationVC() {
        self.navigationItem.rightBarButtonItem?.target = nil

        let index: Int
        index = segmentIndex == 0 ? 0 : segmentIndex - 1

        let vc = AddOperationVC(segmentIndex: index)
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar

        navigationController?.pushViewController(vc, animated: true)

        // Ставит задержку на время анимации перехода. Чтобы диаграмма не обнулялась раньше времени
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [self] in
            categorySort = nil
        }
    }
    
    @objc func handleExchangeRatesUpdated() {
        updateBalanceLabel()
    }
    
}
