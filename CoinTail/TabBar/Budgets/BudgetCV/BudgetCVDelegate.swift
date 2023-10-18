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
        let budgetData: BudgetClass = daySections[indexPath.section].budgets[indexPath.row]
        
        self.navigationItem.rightBarButtonItem?.target = nil
                
        let vc = AddBudgetVC(budgetID: budgetData.id)
        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
