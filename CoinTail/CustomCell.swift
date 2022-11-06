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
        view.backgroundColor = UIColor.gray
        return view
    }()
         
    lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
         
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
         
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        addSubview(dateLabel)
        backView.addSubview(categoryImage)
        backView.addSubview(amountLabel)
        backView.addSubview(categoryLabel)
        backView.addSubview(descriptionLabel)
        
        backView.easy.layout([Height(90), Left(4), Right(4), Bottom(10)])
        
        dateLabel.easy.layout([CenterX(), Top(5)])
        
        categoryImage.easy.layout([Height(60), Width(60), Left(4), CenterY()])
        amountLabel.easy.layout([Height(30), Left(10).to(categoryImage), Top(10)])
        categoryLabel.easy.layout([Height(30), Left(20).to(categoryImage), Bottom(10)])
        descriptionLabel.easy.layout([Height(30), Width(120), Right(4), Top(10)])
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
//        categoryImage.layer.cornerRadius = 20
        categoryImage.clipsToBounds = true
    } 
    
}
