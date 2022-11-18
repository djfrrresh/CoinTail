//
//  PopActions.swift
//  CoinTail
//
//  Created by Eugene on 15.11.22.
//

import UIKit


extension AddNewOperationPopVC {
    
    // Открывается маленькое окно с созданием новой категории
    @objc func addNewCategoryAction() {
        let popUpVC = CustomPopVC(popVC: self)
        popUpVC.addNewCategoryDelegate = self
        
        self.present(popUpVC, animated: true, completion: nil)
    }
    
}
