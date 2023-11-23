//
//  BudgetCVDelegate.swift
//  CoinTail
//
//  Created by Eugene on 06.07.23.
//

import UIKit


extension BudgetsVC: UICollectionViewDelegate {
    
    // При нажатии на категорию закрывается контроллер и она передается в кнопку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var filteredBudgets: [BudgetClass] = []

        if indexPath.section == 0 {
            filteredBudgets = budgets.filter { $0.isActive }
        } else {
            filteredBudgets = budgets.filter { !$0.isActive }
        }
        
        let budgetData: BudgetClass = filteredBudgets[indexPath.row]
        
        self.navigationItem.rightBarButtonItem?.target = nil
                
        let vc = AddBudgetVC(budgetID: budgetData.id)
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
