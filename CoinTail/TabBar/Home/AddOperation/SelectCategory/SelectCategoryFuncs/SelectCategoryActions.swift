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
        let vc = CreateCategoryVC(segmentTitle: addOperationVCSegmentType ?? "Expense")
        vc.addNewCategoryDelegate = self
        vc.addNewSubcategoryDelegate = self
        vc.modalPresentationStyle = .overCurrentContext

        self.present(vc, animated: true, completion: nil)
    }
    
}
