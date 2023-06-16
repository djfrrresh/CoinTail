//
//  CategoryCell.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import EasyPeasy


final class CategoryCVCell: UICollectionViewCell {
    
    static let id = "CategoryCVCell"
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        return view
    }()
    
    let categoryName: UILabel = getCategoryLabel()
    
    static func getCategoryLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backView)
        backView.addSubview(categoryName)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Edges()
        ])
        
        categoryName.easy.layout([
            Center()
        ])
    }
    
    static func size(data: String) -> CGSize {
        let category = getCategoryLabel()
        category.text = data
                
        let textWidth = category.sizeThatFits(.init(width: 0, height: 0)).width
        
        // Динамический размер одной ячейки с отступами по 16 с краёв
        return .init(width: textWidth + 16 * 2, height: 32)
    }

}
