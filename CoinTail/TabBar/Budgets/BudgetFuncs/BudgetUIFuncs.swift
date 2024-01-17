//
//  BudgetsUIFuncs.swift
//  CoinTail
//
//  Created by Eugene on 29.06.23.
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


extension BudgetsVC {
    
    func budgetSubviews() {
        self.view.addSubview(customNavBar)
        self.view.addSubview(budgetCV)
        
        customNavBar.easy.layout([
            Height(96),
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Left(),
            Right()
        ])
        
        budgetCV.easy.layout([
            Top().to(customNavBar, .bottom),
            CenterX(),
            Left(16),
            Right(16),
            Bottom()
        ])
    }
    
    func areBudgetsEmpty() {
        let isEmpty = budgets.isEmpty
        
        budgetsEmojiLabel.isHidden = !isEmpty
        noBudgetsLabel.isHidden = !isEmpty
        budgetsDescriptionLabel.isHidden = !isEmpty
        addBudgetButton.isHidden = !isEmpty
        emptyDataView.isHidden = !isEmpty
        
        budgetCV.isHidden = isEmpty
    }
    
}
