//
//  SelectCategoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension SelectCategoryVC: AddNewCategory {
    
    func sendNewCategoryData(category: Category) {
        Categories.shared.addNewCategory(category, type: addOperationVCSegment)
        
        selectCategoryCV.reloadData()
    }
    
}
