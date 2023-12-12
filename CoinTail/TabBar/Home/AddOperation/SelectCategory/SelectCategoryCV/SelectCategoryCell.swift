//
//  SelectCategoryCell.swift
//  CoinTail
//
//  Created by Eugene on 20.09.23.
//

import UIKit
import EasyPeasy
import RealmSwift


final class SelectCategoryCell: UICollectionViewCell {
    
    static let id = "SelectCategoryCell"

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    let pencilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.pencil")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let categoryIcon: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 24)
        label.backgroundColor = .clear
        
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryIcon)
        contentView.addSubview(pencilImageView)
        
        contentView.easy.layout([
            Edges()
        ])
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
        
        pencilImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
        
        categoryIcon.easy.layout([
            CenterY(),
            Height(24),
            Width(24),
            Left(16)
        ])
        
        categoryLabel.easy.layout([
            CenterY(),
            Left(16).to(categoryIcon, .right),
            Right(16).to(chevronImageView, .left)
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left().to(categoryLabel, .left),
            Height(0.5)
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    func isEditingCategory(_ isEditing: Bool) {
        chevronImageView.isHidden = isEditing
        pencilImageView.isHidden = !isEditing
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 52
        )
    }
    
}
