//
//  SelectCategoryActions.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension SelectCategoryVC {
    
    // Открывается окно с созданием новой категории
    @objc func goToCreateCategoryVC() {
        let vc = CreateCategoryVC()
        vc.addNewCategoryDelegate = self
        vc.modalPresentationStyle = .overCurrentContext

        self.present(vc, animated: true, completion: nil)
    }
    
}
