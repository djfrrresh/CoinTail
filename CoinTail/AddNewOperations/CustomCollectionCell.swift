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
    
    private let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        contentView.layer.cornerRadius = 15
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
//        contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImage.easy.layout(Height(54), Width(54), CenterY(), CenterX())
        categoryName.easy.layout(Left(4), Right(4), Top(16).to(categoryImage))
    }
    
    func configure(label: String, image: String) {
        categoryName.text = label
        categoryImage.image = UIImage(systemName: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
