//
//  CreateCategoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


extension CreateCategoryVC {
    
    func setupUI(with category: CategoryProtocol) {
        categoryName = category.name
        categoryIcon = category.image
        
        deleteCategoryButton.isHidden = false
    }

    func createCategorySubviews() {
        self.view.addSubview(createCategoryCV)
        self.view.addSubview(deleteCategoryButton)
        
        let createCategoryCVHeight: CGFloat = (categoryID != nil ? 2 : 4) * 44
        createCategoryCV.easy.layout([
            Left(16),
            Right(16),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Height(createCategoryCVHeight)
        ])
        
        deleteCategoryButton.easy.layout([
            Left(16),
            Right(16),
            Top(24).to(createCategoryCV, .bottom),
            Height(52)
        ])
    }
    
    func createCategoryNavBar() {
        let title = (categoryID != nil) ? "Edit".localized() : "Save".localized()

        let saveButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(createCategoryAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = createCategoryCV.cellForItem(at: indexPath) as? CreateCategoryCell {
            cell.updateSubMenuLabel(text)
        }
    }
    
}
