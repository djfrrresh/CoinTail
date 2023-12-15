//
//  SelectCategoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.11.23.
//

import UIKit
import EasyPeasy


extension SelectCategoryVC {
    
    func selectCategorySubviews() {
        self.view.addSubview(createCategoryButton)
        self.view.addSubview(selectCategoryCV)
        self.view.addSubview(categorySearchBar)
        
        categorySearchBar.easy.layout([
            Left(16),
            Right(16),
            Height(36),
            CenterX(),
            Top(16).to(self.view.safeAreaLayoutGuide, .top)
        ])
        
        createCategoryButton.easy.layout([
            Bottom(16).to(self.view.safeAreaLayoutGuide, .bottom),
            Left(16),
            Right(16),
            Height(52)
        ])
        
        selectCategoryCV.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            Top(24).to(categorySearchBar, .bottom),
            Bottom(24).to(createCategoryButton, .top)
        ])
    }
    
    func selectCategoryNavBar() {
        let actionButton = UIBarButtonItem(title: categoryNavBarTitle, style: .plain, target: self, action: #selector(editCategoryAction))
            
        self.navigationItem.rightBarButtonItem = actionButton
    }
    
    func setTitle() {
        if let categoryID = categoryID,
           let category = Categories.shared.getCategory(for: categoryID) {
            self.title = category.name
        } else {
            switch operationSegmentType {
            case .expense:
                title = "Expense categories".localized()
            case .income:
                title = "Income categories".localized()
            case .allOperations:
                return
            }
        }
    }
    
    func isCategoryEmpty() {
        let isEmpty = categories.isEmpty
        
        categoriesImageView.isHidden = !isEmpty
        noCategoriesLabel.isHidden = !isEmpty
        categoriesDescriptionLabel.isHidden = !isEmpty
        addCategoryButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        createCategoryButton.isHidden = isEmpty || !isParental
        categorySearchBar.isHidden = isEmpty
        selectCategoryCV.isHidden = isEmpty
        
        if isEmpty {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            selectCategoryNavBar()
        }
    }
    
}
