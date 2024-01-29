//
//  BasicNoDataFuncs.swift
//  CoinTail
//
//  Created by Eugene on 22.01.24.
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


extension BasicVC {
    
    static func getAddDataButton(text: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle(text.localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }
    static func getNoDataLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text.localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }
    static func getDataDescriptionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text.localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }
    
    static func getDataEmojiLabel(_ emoji: String) -> UILabel {
        let label = UILabel()
        label.text = emoji
        label.font = UIFont(name: "SFProText-Regular", size: 100)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        return label
    }
    
    static func getDataImageView(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: name)

        return imageView
    }
    
    func emptyDataSubviews(dataView: UIView, noDataLabel: UILabel, dataDescriptionLabel: UILabel, addDataButton: UIButton) {
        self.view.addSubview(emptyDataView)
        
        emptyDataView.easy.layout([
            Left(16),
            Right(16),
            Center(),
            Height(BasicVC.noDataViewSize(
                noDataLabel: noDataLabel,
                descriptionLabel: dataDescriptionLabel
            ))
        ])

        emptyDataView.addSubview(dataView)
        emptyDataView.addSubview(noDataLabel)
        emptyDataView.addSubview(dataDescriptionLabel)
        emptyDataView.addSubview(addDataButton)
        
        dataView.easy.layout([
            Height(100),
            Width(100),
            Top(),
            CenterX()
        ])
        
        noDataLabel.easy.layout([
            Left(),
            Right(),
            Top(32).to(dataView, .bottom)
        ])
        
        dataDescriptionLabel.easy.layout([
            Left(),
            Right(),
            Top(16).to(noDataLabel, .bottom)
        ])

        addDataButton.easy.layout([
            Height(52),
            Left(),
            Right(),
            CenterX(),
            Top(16).to(dataDescriptionLabel, .bottom),
            Bottom()
        ])
    }
    
    // Отображает динамически высоту для View
    static private func noDataViewSize(noDataLabel: UILabel, descriptionLabel: UILabel) -> CGFloat {
        let padding: CGFloat = 16.0
        let imagePadding: CGFloat = 32.0
        
        let textWidth = UIScreen.main.bounds.width - (2 * padding)
    
        let noDataLabelHeight: CGFloat = noDataLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let descriptionHeight: CGFloat = descriptionLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        
        let imageViewHeight: CGFloat = 100.0
        let buttonHeight: CGFloat = 52.0
        
        let viewHeight = imageViewHeight + imagePadding + noDataLabelHeight + descriptionHeight + padding * 2 + buttonHeight
                        
        return viewHeight
    }
    
}
