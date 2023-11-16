//
//  CreateCategoryUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


extension CreateCategoryVC {

    func createCategorySubviews() {
        self.view.addSubview(createCategoryCV)
            
        createCategoryCV.easy.layout([
            Left(16),
            Right(16),
            Top(32).to(self.view.safeAreaLayoutGuide, .top),
            Bottom()
        ])
    }
    
    func createCategoryNavBar() {
        let title = (categoryID != nil || subcategoryID != nil) ? "Edit".localized() : "Save".localized()

        let saveButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(createCategoryAction))
            
        self.navigationItem.rightBarButtonItem = saveButton
        //TODO: расскоментить тут и в AddAccountVC
//        self.navigationItem.rightBarButtonItem?.isEnabled = (categoryID != nil || subcategoryID != nil) ? true : false
    }
    
}
