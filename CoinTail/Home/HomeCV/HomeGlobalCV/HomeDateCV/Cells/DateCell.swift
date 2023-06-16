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
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    let periodLabel: UILabel = getPeriodLabel()
    
    static func getPeriodLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backView)
        backView.addSubview(periodLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Left(0),
            Right(0),
            Height(32),
            CenterY()
        ])
        
        periodLabel.easy.layout([
            Left(8),
            Right(8),
            Center()
        ])
    }
    
    override var isSelected: Bool {
       didSet {
           if isSelected {
               UIView.animate(withDuration: 0.2) { [self] in
                   backView.backgroundColor = .black
                   periodLabel.textColor = .white
               }
           } else {
               UIView.animate(withDuration: 0.2) { [self] in
                   backView.backgroundColor = .white
                   periodLabel.textColor = .black
               }
           }
       }
   }
    
    static func size(data: String) -> CGSize {
        let period = getPeriodLabel()
        period.text = data
                
        let textWidth = period.sizeThatFits(.init(width: 0, height: 0))
        
        // Динамический размер одной ячейки с отступами по 8 с краёв
        return .init(width: textWidth.width + 8 * 2, height: 32)
    }

}
