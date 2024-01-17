//
//  CreateCategoryUIFuncs.swift
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
        let saveButton = UIBarButtonItem(title: "Save".localized(), style: .plain, target: self, action: #selector(createCategoryAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func updateCell(at indexPath: IndexPath, text: String) {
        if let cell = createCategoryCV.cellForItem(at: indexPath) as? CreateCategoryCell {
            cell.updateSubMenuLabel(text)
        }
    }
    
}
