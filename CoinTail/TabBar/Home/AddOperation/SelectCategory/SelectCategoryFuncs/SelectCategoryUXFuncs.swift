//
//  SelectCategoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 08.12.23.
//

import UIKit


extension SelectCategoryVC {
    
    func selectCategoryTargets() {
        createCategoryButton.addTarget(self, action: #selector(goToCreateCategoryVC), for: .touchUpInside)
        addCategoryButton.addTarget(self, action: #selector(goToCreateCategoryVC), for: .touchUpInside)
    }
    
}
