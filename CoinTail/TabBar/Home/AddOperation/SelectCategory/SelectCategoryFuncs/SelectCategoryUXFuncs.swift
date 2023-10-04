//
//  SelectCategoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


extension SelectCategoryVC: AddNewCategory, AddNewSubcategory {
    
    func sendNewCategoryData(category: Category) {
        Categories.shared.addNewCategory(category, type: operationSegmentType)
        
        selectCategoryCV.reloadData()
    }
    
    func sendNewSubcategoryData(subcategory: Subcategory) {
        Categories.shared.addNewSubcategory(subcategory)
        
        selectCategoryCV.reloadData()
    }
}
