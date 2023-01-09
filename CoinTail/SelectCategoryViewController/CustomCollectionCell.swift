//
//  CustomCollectionCell.swift
//  CoinTail
//
//  Created by Eugene on 08.11.22.
//

import UIKit
import EasyPeasy


class CustomCollectionCell: UICollectionViewCell {
    
    static let id = "CustomCollectionCell"
    
    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.black
        return imageView
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.9)
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.backgroundColor = .white
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImage.easy.layout([Height(54), Width(54), CenterY(), CenterX()])
        categoryName.easy.layout([Left(4), Right(4), Top(16).to(categoryImage)])
    }
    
    func configure(label: String, image: String) {
        categoryName.text = label
        categoryImage.image = UIImage(systemName: image)
    }
    
}
