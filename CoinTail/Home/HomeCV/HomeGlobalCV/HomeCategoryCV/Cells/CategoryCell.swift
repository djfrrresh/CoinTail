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
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        return view
    }()
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
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
            Left(),
            Right(),
            Height(32),
            CenterY()
        ])
        
        categoryName.easy.layout([
            Left(16),
            Right(16),
            CenterX(),
            CenterY()
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: 32
        )
    }

}
