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
    
    let xmarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let categoryName: UILabel = getCategoryLabel()
    
    var isXmark: Bool = false
    
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
        backView.addSubview(xmarkImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Edges()
        ])
        
        if isXmark {
            categoryName.easy.layout([
                Left(16),
                CenterY()
            ])
            xmarkImage.easy.layout([
                Left(8).to(categoryName),
                Height(20),
                Width(20),
                CenterY()
            ])
            
            xmarkImage.isHidden = false
        } else {
            categoryName.easy.layout([
                Center()
            ])
            
            xmarkImage.easy.clear()
            
            xmarkImage.isHidden = true
        }
    }
    
    static func size(data: String, isXmark: Bool = false) -> CGSize {
        let category = getCategoryLabel()
        category.text = data
        
        var xmarkWidth: CGFloat = 0
        
        if isXmark {
            xmarkWidth += 16 + 8
        }
                
        let textWidth = category.sizeThatFits(.init(width: 0, height: 0)).width
        
        // Динамический размер одной ячейки с отступами по 16 с краёв
        return .init(width: textWidth + 16 * 2 + xmarkWidth, height: 32)
    }

}
