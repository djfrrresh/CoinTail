//
//  AddBudgetCell.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit
import EasyPeasy


protocol AddBudgetCellDelegate: AnyObject {
    func cell(didUpdateBudgetAmount amount: String?)
}

final class AddBudgetCell: UICollectionViewCell {
    
    static let id = "AddBudgetCell"
    
    weak var addBudgetCellDelegate: AddBudgetCellDelegate?
            
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()
    let subMenuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")

        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    let budgetAmountTF: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return textField
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        budgetAmountTF.delegate = self

        contentView.addSubview(menuLabel)
        contentView.addSubview(budgetAmountTF)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(subMenuLabel)
        contentView.addSubview(separatorView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.easy.layout([
            Edges()
        ])

        menuLabel.easy.layout([
            Left(16),
            CenterY()
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left(16),
            Height(0.5)
        ])
        
        chevronImageView.easy.layout([
            Right(16),
            CenterY(),
            Height(20),
            Width(20)
        ])
        
        subMenuLabel.easy.layout([
            CenterY(),
            Right(4).to(chevronImageView, .left)
        ])
        
        budgetAmountTF.easy.layout([
            Left(16),
            Right(16),
            Top(),
            Bottom()
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    func updateSubMenuLabel(_ labelText: String) {
        subMenuLabel.text = labelText
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 44
        )
    }
    
}
