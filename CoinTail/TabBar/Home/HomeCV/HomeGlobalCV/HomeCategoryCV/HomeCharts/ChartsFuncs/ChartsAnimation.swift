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


protocol CategoryIsHiddenDelegate: AnyObject {
    func categoryIsHidden(isHidden: Bool)
}

protocol ArrowTapDelegate: AnyObject {
    func arrowTap(isLeft: Bool)
}

extension HomeCategoryCell {
    
    // Анимация появления круговой диаграммы вместо плоской
    @objc func pieChartAction() {
        if pieChart.isHidden {
            UIView.animate(withDuration: 0.3) { [self] in
                pieChart.isHidden = false
                categoriesCV.isHidden = false
                progressView.isHidden = true
                arrowImageLeft.isHidden = false
                arrowImageRight.isHidden = false
                
                pieChart.alpha = 1
                categoriesCV.alpha = 1
                progressView.alpha = 0
                
//                self.contentView.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) { [self] in
                pieChart.isHidden = true
                categoriesCV.isHidden = true
                progressView.isHidden = false
                arrowImageLeft.isHidden = true
                arrowImageRight.isHidden = true
                
                pieChart.easy.clear()

                pieChart.alpha = 0
                categoriesCV.alpha = 0
                progressView.alpha = 1

//                self.contentView.layoutIfNeeded()
            }
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
