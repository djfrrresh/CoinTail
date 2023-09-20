//
//  CreateCategoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension CreateCategoryVC: SendСategory {
    
    func sendCategoryData(category: Category) {
        parentalCategoryButton.setTitle(category.name, for: .normal)
    }
    
    // Закрывает всплывающее окно при нажатии за его пределы
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           let touch = touches.first
           if touch?.view != popUpView {
               self.dismiss(animated: true, completion: nil)
           }
       }
    
    func createTargets() {
        addButton.addTarget(self, action: #selector(addNewItemAction), for: .touchUpInside)
        selectColorButton.addTarget(self, action: #selector(didTapSelectColor), for: .touchUpInside)
        parentalCategoryButton.addTarget(self, action: #selector(goToSelectCategoryVC), for: .touchUpInside)
    }
    
}
