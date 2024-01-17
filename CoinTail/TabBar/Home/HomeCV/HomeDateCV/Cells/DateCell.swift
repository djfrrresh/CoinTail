//
//  HomeDateCVCell.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
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


final class DateCVCell: UICollectionViewCell {
    
    static let id = "DateCVCell"
    
    let periodLabel: UILabel = getPeriodLabel()
    
    static func getPeriodLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)

        return label
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 16
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(periodLabel)
        
        contentView.easy.layout([
            Edges()
        ])
        
        periodLabel.easy.layout([
            Left(12),
            Right(12),
            Center()
        ])
    }
    
    var selectedCell: Int? {
        didSet {
            currentCell(selectedCell != nil)
        }
    }
    
    static func size(data: String) -> CGSize {
        let period = getPeriodLabel()
        period.text = data
                
        let textWidth = period.sizeThatFits(.init(width: 0, height: 0))
        
        // Динамический размер одной ячейки с отступами по 8 с краёв
        return .init(width: textWidth.width + 12 * 2, height: 40)
    }
    
    private func currentCell(_ isSelected: Bool) {
        if isSelected {
            contentView.backgroundColor = .white
            periodLabel.textColor = UIColor(named: "primaryAction")
        } else {
            contentView.backgroundColor = UIColor(named: "dateCellGray")
            periodLabel.textColor = .black
        }
    }

}
