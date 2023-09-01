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
            pieChart.isHidden = targetVisibility
            categoriesCV.isHidden = targetVisibility
            progressView.isHidden = !targetVisibility
            arrowImageLeft.isHidden = !targetVisibility
            arrowImageRight.isHidden = !targetVisibility

            pieChart.alpha = targetAlpha
            categoriesCV.alpha = targetAlpha
            progressView.alpha = 1 - targetAlpha

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
