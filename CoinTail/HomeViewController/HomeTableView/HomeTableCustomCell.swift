//
//  CustomCell.swift
//  CoinTail
//
//  Created by Eugene on 24.10.22.
//

import UIKit
import EasyPeasy


class CustomCell: UITableViewCell {
            
    lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
         
    lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = UIColor.black
        return image
    }()
    
    lazy var arrowImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
         
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
         
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backView.layer.cornerRadius = 8
        
        addSubview(backView)
        addSubview(categoryLabel)
        addSubview(amountLabel)
        addSubview(arrowImage)
        backView.addSubview(categoryImage)
        
        backView.easy.layout([Height(68), Width(44), Left(16)])
                
        categoryImage.easy.layout([CenterY().to(backView), CenterX().to(backView), Height(44), Width(44)])
        arrowImage.easy.layout([CenterY(), Right(23), Height(24), Width(16)])

        categoryLabel.easy.layout([Height(16), Left(10).to(categoryImage), CenterY()])
        amountLabel.easy.layout([Height(16), Right(15).to(arrowImage, .left), CenterY()])
        
        // Меняет цвет стрелки
        arrowImage.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        arrowImage.tintColor = UIColor.gray
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        categoryImage.clipsToBounds = true
    } 
    
}
