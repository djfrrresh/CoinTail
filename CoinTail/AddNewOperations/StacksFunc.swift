//
//  AddNewOperationStacksFunc.swift
//  CoinTail
//
//  Created by Eugene on 25.10.22.
//

import UIKit
import EasyPeasy


extension AddNewOperationVC {
    
    // Создание стака между двумя элементами
    func setUniqueStack (stack: UIStackView, view_1: UIView, view_2: UIView?) {
        stack.axis = .vertical
        stack.spacing = 6
        stack.addArrangedSubview(view_1)
        stack.addArrangedSubview(view_2!)
    }
    
}
