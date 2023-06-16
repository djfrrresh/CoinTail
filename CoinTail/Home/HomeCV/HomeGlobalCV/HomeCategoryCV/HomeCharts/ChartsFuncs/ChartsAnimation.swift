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

protocol CategoryDelegate: AnyObject {
    func categoryIsHidden(isHidden: Bool)
}

extension HomeCategoryCell {
    
    // Анимация появления круговой диаграммы вместо плоской
    @objc func pieChartAction() {
        if pieChart.isHidden {
            UIView.animate(withDuration: 0.3) { [self] in
                pieChart.isHidden = false
                pieChart.easy.layout([
                    Top(),
                    Height(250),
                    Width(250),
                    CenterX()
                ])
                categoriesCV.isHidden = false
                progressView.isHidden = true
                
                pieChart.alpha = 1
                categoriesCV.alpha = 1
                progressView.alpha = 0
                
                self.contentView.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                pieChart.isHidden = true
                pieChart.easy.layout([
                    Top(),
                    Height(0),
                    Width(250),
                    CenterX()
                ])
                categoriesCV.isHidden = true
                progressView.isHidden = false

                pieChart.alpha = 0
                categoriesCV.alpha = 0
                progressView.alpha = 1

                self.contentView.layoutIfNeeded()
            }
        }
        categoryDelegate?.categoryIsHidden(isHidden: pieChart.isHidden)
    }
    
}
