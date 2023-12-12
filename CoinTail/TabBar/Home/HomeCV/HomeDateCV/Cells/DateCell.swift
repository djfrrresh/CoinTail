//
//  HomeDateCVCell.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

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
