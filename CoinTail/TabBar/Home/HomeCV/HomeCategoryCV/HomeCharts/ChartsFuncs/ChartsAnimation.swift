//
//  ChartsAnimation.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
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
import Charts
import EasyPeasy


protocol CategoryIsHiddenDelegate: AnyObject {
    func categoryIsHidden(isHidden: Bool)
}

protocol ArrowTapDelegate: AnyObject {
    func arrowTap(isLeft: Bool)
}

extension HomeCategoryCell {
    
    // Анимация появления круговой диаграммы вместо плоской
    @objc func pieChartAction() {
        let targetAlpha: CGFloat
        let targetVisibility: Bool
                
        if pieChart.isHidden {
            targetAlpha = 1
            targetVisibility = false
        } else {
            targetAlpha = 0
            targetVisibility = true
            pieChart.easy.clear()
        }
        
        UIView.animate(withDuration: 0.3) { [self] in
            periodLabel.isHidden = targetVisibility
            amountForPeriodLabel.isHidden = targetVisibility
            pieChart.isHidden = targetVisibility
            categoriesCV.isHidden = targetVisibility
            arrowImageLeft.isHidden = targetVisibility
            arrowImageRight.isHidden = targetVisibility
            openDiagramsView.isHidden = !targetVisibility
            openDiagramsLabel.isHidden = !targetVisibility
            diagramsDescriptionLabel.isHidden = !targetVisibility
            diargamsImageView.isHidden = !targetVisibility

            pieChart.alpha = targetAlpha
            categoriesCV.alpha = targetAlpha
            openDiagramsLabel.alpha = 1 - targetAlpha
            diagramsDescriptionLabel.alpha = 1 - targetAlpha
            diargamsImageView.alpha = 1 - targetAlpha

            self.contentView.layoutIfNeeded()
        }
        
        categoryisHiddenDelegate?.categoryIsHidden(isHidden: pieChart.isHidden)
    }
    
    @objc func leftArrowTap() {
        arrowTapDelegate?.arrowTap(isLeft: true)
    }
    
    @objc func rightArrowTap() {
        arrowTapDelegate?.arrowTap(isLeft: false)
    }
}
