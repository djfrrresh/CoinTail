//
//  CategoryCVCell.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


final class SelectCategoryCVCell: UICollectionViewCell {
    
    static let id = "SelectCategoryCVCell"

    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
        
        return view
    }()
    
    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        return imageView
    }()
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    let categoryColor: UIColor = {
        var color = UIColor()
        color = .clear
        
        return color
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backView)
        contentView.addSubview(categoryName)
        backView.addSubview(categoryImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Edges()
        ])
        
        categoryImage.easy.layout([
            Center(),
            Height(52),
            Width(52)
        ])
        
        categoryName.easy.layout([
            Left(4),
            Right(4),
            Top(10).to(backView, .bottom)
        ])
    }
    
    // Изменение цвета выбранной иконки
    override var isSelected: Bool {
       didSet {
           if isSelected {
               UIView.animate(withDuration: 0.3) { [self] in // for animation effect
                   backView.layer.borderWidth = 3
               }
           } else {
               UIView.animate(withDuration: 0.3) { [self] in // for animation effect
                   backView.layer.borderWidth = 1
               }
           }
       }
   }
}
