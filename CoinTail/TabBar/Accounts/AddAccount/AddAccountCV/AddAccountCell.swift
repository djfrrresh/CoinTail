//
//  AddAccountCell.swift
//  CoinTail
//
//  Created by Eugene on 30.10.23.
//

import UIKit
import EasyPeasy


protocol AddAccountCellDelegate: AnyObject {
    func cell(didUpdateAccountName name: String?)
    func cell(didUpdateAccountAmount amount: String?)
    func cell(didUpdateOnOffToggle isOn: Bool)
}

final class AddAccountCell: UICollectionViewCell {
    
    static let id = "AddAccountCell"
    
    weak var addAccountCellDelegate: AddAccountCellDelegate?
            
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
    let currencyLabel: UILabel = {
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
    
    let onOffToggle: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = true
        
        return uiSwitch
    }()
    
    let accountNameTF: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.autocorrectionType = .no
        
        return textField
    }()
    let accountAmountTF: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return textField
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accountAmountTF.delegate = self
        accountNameTF.delegate = self
        
        onOffToggle.addTarget(self, action: #selector(switchValueChanged), for: UIControl.Event.valueChanged)
                
        contentView.addSubview(backView)
        
        backView.addSubview(menuLabel)
        backView.addSubview(accountNameTF)
        backView.addSubview(accountAmountTF)
        backView.addSubview(chevronImageView)
        backView.addSubview(currencyLabel)
        backView.addSubview(separatorView)
        backView.addSubview(onOffToggle)
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
        
        currencyLabel.easy.layout([
            CenterY(),
            Right(4).to(chevronImageView, .left)
        ])
        
        onOffToggle.easy.layout([
            Right(16),
            CenterY()
        ])
        
        accountNameTF.easy.layout([
            Left(16),
            Right(16),
            Top(),
            Bottom()
        ])
        
        accountAmountTF.easy.layout([
            Left(16),
            Right(16),
            Top(),
            Bottom()
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    func updateCurrencyLabel(_ selectedCurrency: String) {
        currencyLabel.text = selectedCurrency
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        addAccountCellDelegate?.cell(didUpdateOnOffToggle: sender.isOn)
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 44
        )
    }
    
}
