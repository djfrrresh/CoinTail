//
//  SelectCategoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.11.23.
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
import EasyPeasy


extension SelectCategoryVC {
    
    func selectCategorySubviews() {
        self.view.addSubview(createCategoryButton)
        self.view.addSubview(selectCategoryCV)
        self.view.addSubview(categorySearchBar)
        
        categorySearchBar.easy.layout([
            Left(8),
            Right(8),
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
        let actionButton = UIBarButtonItem(title: "Edit".localized(), style: .plain, target: self, action: #selector(editCategoryAction))
            
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
        
        categoriesEmojiLabel.isHidden = !isEmpty
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
