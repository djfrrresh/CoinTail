//
//  CreateCategoryUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import RealmSwift


extension CreateCategoryVC: SendCategoryID, CreateCategoryCellDelegate {
    
    func sendCategoryData(id: ObjectId) {
        categoryID = id
        
        guard let category = Categories.shared.getCategory(for: id) else { return }
                
        mainCategoryName = category.name
    }
    
    func cell(didUpdateCategoryName name: String?) {
        categoryName = name
    }
    
    func cell(didUpdateCategoryIcon icon: String?) {
        categoryIcon = icon
    }
    
    func cell(didUpdateOnOffToggle isOn: Bool) {
        isToggleOn = isOn
        
        if !isOn {
            mainCategoryName = ""
        }
        
        if let cell = createCategoryCV.cellForItem(at: IndexPath(row: 3, section: 0)) as? CreateCategoryCell {
            cell.menuLabel.textColor = isToggleOn ? .black : UIColor(named: "secondaryTextColor")
        }
    }
    
    func createCategoryTargets() {
        deleteCategoryButton.addTarget(self, action: #selector(removeCategory), for: .touchUpInside)
    }
    
    func categoryValidation(name: String, icon: String, mainCategory: String, completion: ((String, String) -> Void)? = nil) {
        let missingName = name == ""
        let missingIcon = icon == ""
        let missingMainCategory = mainCategory == ""

        if missingName {
            infoAlert("Category name is missing".localized())
        } else if missingIcon {
            infoAlert("Category icon not selected".localized())
        } else if isToggleOn && missingMainCategory {
            infoAlert("No parent category selected".localized())
        }
//        else if isSubcategory {
//            if AppSettings.shared.premium?.isPremiumActive ?? false {
            //TODO: premium
//                infoAlert("Creating subcategories is only available with a Premium subscription".localized())

//                return
//            }
//        }
        else {
            completion?(name, icon)
        }
    }
    
}
