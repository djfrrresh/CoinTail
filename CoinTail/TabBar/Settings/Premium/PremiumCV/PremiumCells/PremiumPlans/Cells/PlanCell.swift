//
//  PlanCell.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
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


protocol SelectedCell: AnyObject {
    func scrollToSelectedCell(indexPath: IndexPath)
}

final class PlanCell: UICollectionViewCell {
    
    static let id = "PlanCell"
    
    static private let interCellsInset: CGFloat = 8
    static private let leftRightInset: CGFloat = 16 * 2
    static private let textEdgesInset: CGFloat = 16 * 2
    static private let cellWidth = (UIScreen.main.bounds.width-interCellsInset-leftRightInset)/2
    static private let textWidth = cellWidth - textEdgesInset
    
    let titleLabel: UILabel = getTitleLabel()
    let priceLabel: UILabel = getPriceLabel()
    
    weak var planDelegate: SelectedCell?
    
    var selectedCell: IndexPath? {
        didSet {
            selectedCell(selectedCell != nil)
            
            if let selectedCell = selectedCell, oldValue != selectedCell {
                planDelegate?.scrollToSelectedCell(indexPath: selectedCell)
            }
        }
    }
    
    private let trialIndicator:  UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryAction")
        view.layer.cornerRadius = 10.5
        view.clipsToBounds = true
        
        return view
    }()
    
    private let trialIndicatorLabel:  UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: textWidth - (8 * 2), height: 0))
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 11)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .white
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor(named: "primaryAction")?.cgColor
        contentView.layer.cornerRadius = 16
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(trialIndicator)
        
        trialIndicator.addSubview(trialIndicatorLabel)
        
        titleLabel.easy.layout([
            Top(16),
            Left(16),
            Right(16)
        ])
        
        trialIndicator.easy.layout([
            Top(4).to(titleLabel),
            Left(16),
            Height(21)
        ])
        
        trialIndicatorLabel.easy.layout([
            CenterY(),
            Left(8),
            Right(8)
        ])
        
        priceLabel.easy.layout([
            Bottom(16),
            Left(16),
            Right(16)
        ])
    }
    
    func setTrialIndicator(_ text: String?) {
        trialIndicator.isHidden = text == nil
        
        guard !trialIndicator.isHidden else { return }
        
        trialIndicatorLabel.text = text
        trialIndicatorLabel.sizeToFit()
        
        trialIndicator.easy.layout([
            Width(
                min(trialIndicatorLabel.frame.width + (8 * 2), PlanCell.textWidth)
            )
        ])
    }
    
    func selectedCell(_ isSelected: Bool) {
        contentView.layer.borderWidth = isSelected ? 1.5 : 0
    }
    
    static func getTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 28)
        label.textColor = .black
        label.numberOfLines = 1
        
        return label
    }
    
    static func getPriceLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 1
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }
    
    static func size(_ data: PlanData) -> CGSize {
        let title = getTitleLabel()
        title.text = data.title
        
        let titleSize = title.sizeThatFits(.init(width: textWidth, height: 0))
        let description = getPriceLabel()
        description.text = "₽ \(data.price)/\(data.period)"
        let descriptionSize = description.sizeThatFits(.init(width: textWidth, height: 0))
        
        let trialIndicatorHeight: CGFloat = 21
        
        let textHeight = titleSize.height + descriptionSize.height + trialIndicatorHeight + textEdgesInset + 4 + 8
        let maxWidth = max(titleSize.width, descriptionSize.width) + leftRightInset
        
        return .init(
            width: max(maxWidth, cellWidth),
            height: textHeight
        )
    }
    
}
