//
//  ChartsAnimation.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import MultipleProgressBar
import Charts
import EasyPeasy


extension HomeCategoryCell {
    
    // Анимация появления круговой диаграммы вместо плоской
    @objc func pieChartAction() {
        chartsAnimate()
    }
    
    // Появление круговой диаграммы
    private func chartsAnimate() {
        if pieChart.isHidden {
            UIView.animate(withDuration: 0.3) { [self] in
                pieChart.isHidden = false
                categoriesCV.isHidden = false
                progressView.isHidden = true
                
                pieChart.alpha = 1
                categoriesCV.alpha = 1
                progressView.alpha = 0

                self.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                pieChart.isHidden = true
                categoriesCV.isHidden = true
                progressView.isHidden = false

                pieChart.alpha = 0
                categoriesCV.alpha = 0
                progressView.alpha = 1

                self.layoutIfNeeded()
            }
        }
    }
    
}
