//
//  HomeTVCell.swift
//  CoinTail
//
//  Created by Eugene on 22.05.23.
//

import UIKit
import EasyPeasy


class HomeTVCell: UITableViewCell {
    
    static let id = "HomeTVCell"
            
    var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    var backImage: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
         
    var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return imageView
    }()
    private var arrowImage: UIImageView = {
        let image = UIImageView()
        // Иконка стрелки у суммы
        image.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.gray
        return image
    }()
         
    var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(backView)
        backView.addSubview(backImage)
        backView.addSubview(categoryLabel)
        backView.addSubview(amountLabel)
        backView.addSubview(arrowImage)
        
        backImage.addSubview(categoryImage)
        
        backgroundColor = UIColor.clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backView.easy.layout([
            Height(68),
            Left(0),
            Right(0),
            CenterY()
        ])
        
        backImage.easy.layout([
            Height(56),
            Width(56),
            CenterY()
        ])

        categoryImage.easy.layout([
            CenterY(),
            CenterX(),
            Height(44),
            Width(44)
        ])
        
        arrowImage.easy.layout([
            CenterY(),
            Right(23),
            Height(24),
            Width(16)
        ])

        categoryLabel.easy.layout([
            Height(16),
            Left(10).to(backImage),
            CenterY()
        ])
        
        amountLabel.easy.layout([
            Height(16),
            Right(15).to(arrowImage, .left),
            CenterY()
        ])
    }
    
}
