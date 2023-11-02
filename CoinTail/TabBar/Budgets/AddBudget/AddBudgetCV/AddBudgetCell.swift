//
//  AddBudgetCell.swift
//  CoinTail
//
//  Created by Eugene on 03.11.23.
//

import UIKit
import EasyPeasy


final class AddBudgetCell: UICollectionViewCell {
    
    static let id = "AddBudgetCell"
    
//    weak var addAccountCellDelegate: AddAccountCellDelegate?
            
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()
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
        label.font = UIFont(name: "SFProText-Regular", size: 16)
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
        
        budgetAmountTF.delegate = self
                        
        contentView.addSubview(backView)
        
        backView.addSubview(menuLabel)
        backView.addSubview(budgetAmountTF)
        backView.addSubview(chevronImageView)
        backView.addSubview(subMenuLabel)
        backView.addSubview(separatorView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
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
    
    func updateCurrencyLabel(_ labelText: String) {
        subMenuLabel.text = labelText
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 44
        )
    }
    
}
