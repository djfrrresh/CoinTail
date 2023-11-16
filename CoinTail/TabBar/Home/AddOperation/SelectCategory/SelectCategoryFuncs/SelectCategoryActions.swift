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
        let vc = CreateCategoryVC(segmentTitle: rawSegmentType ?? "Expense")

        self.navigationItem.rightBarButtonItem?.target = nil
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
