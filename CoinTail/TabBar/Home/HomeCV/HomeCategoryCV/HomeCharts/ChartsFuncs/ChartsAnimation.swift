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
protocol ShowChartsAlertDelegate: AnyObject {
    func showAlert(message: String)
}

extension HomeCategoryCell {
    
    // Анимация появления круговой диаграммы
    @objc func pieChartAction() {
        areRecordsEmpty()
    }
    
    @objc func leftArrowTap() {
        arrowTapDelegate?.arrowTap(isLeft: true)
    }
    
    @objc func rightArrowTap() {
        arrowTapDelegate?.arrowTap(isLeft: false)
    }
    
    func pieChartAnimate(visability: Bool, alpha: CGFloat, duration: CGFloat = 0.3) {
        UIView.animate(withDuration: duration) { [self] in
            periodLabel.isHidden = visability
            amountForPeriodLabel.isHidden = visability
            pieChart.isHidden = visability
            categoriesCV.isHidden = visability
            arrowImageLeft.isHidden = visability
            arrowImageRight.isHidden = visability
            openDiagramsView.isHidden = !visability
            openDiagramsLabel.isHidden = !visability
            diagramsDescriptionLabel.isHidden = !visability
            diargamsImageView.isHidden = !visability

            pieChart.alpha = alpha
            categoriesCV.alpha = alpha
            openDiagramsLabel.alpha = 1 - alpha
            diagramsDescriptionLabel.alpha = 1 - alpha
            diargamsImageView.alpha = 1 - alpha

            self.contentView.layoutIfNeeded()
        }
    }
    
    private func areRecordsEmpty() {
        if segmentType != RecordType.allOperations {
            let records = Records.shared.records.filter { $0.type == segmentType.rawValue }
            
            if records.isEmpty {
                sendAlertDelegate?.showAlert(message: "To display the pie chart you must create at least one transaction".localized())
                
                return
            }
        }
                
        isPieChartHidden()
    }
    
    private func isPieChartHidden() {
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
        
        pieChartAnimate(visability: targetVisibility, alpha: targetAlpha)
        categoryisHiddenDelegate?.categoryIsHidden(isHidden: pieChart.isHidden)
    }
    
}
