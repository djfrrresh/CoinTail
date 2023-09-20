//
//  SelectCategoryCell.swift
//  CoinTail
//
//  Created by Eugene on 20.09.23.
//

import UIKit
import EasyPeasy


final class SelectCategoryCell: UICollectionViewCell {
    
    static let id = "SelectCategoryCell"

    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
        
        return view
    }()
    
    let backImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        return imageView
    }()
    
    let categoryColor: UIColor = {
        var color = UIColor()
        color = .clear
        
        return color
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backView)
        
        backView.addSubview(backImageView)
        backView.addSubview(categoryLabel)
        
        backImageView.addSubview(categoryImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Edges()
        ])
        
        backImageView.easy.layout([
            CenterY(),
            Height(40),
            Width(40),
            Left(8)
        ])
        
        categoryImage.easy.layout([
            Center(),
            Height(32),
            Width(32)
        ])
        
        categoryLabel.easy.layout([
            CenterY(),
            Left(8).to(backImageView, .right)
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 60
        )
    }
    
}
