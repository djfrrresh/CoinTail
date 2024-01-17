//
//  AddAccountCell.swift
//  CoinTail
//
//  Created by Eugene on 30.10.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = .black

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
        textField.textColor = .black
        textField.placeholder = "Account name".localized()
        textField.autocorrectionType = .no
        
        return textField
    }()
    let accountAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount".localized()
        textField.textColor = .black
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return textField
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accountAmountTF.delegate = self
        accountNameTF.delegate = self
        
        onOffToggle.addTarget(self, action: #selector(switchValueChanged), for: UIControl.Event.valueChanged)
                
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(menuLabel)
        contentView.addSubview(accountNameTF)
        contentView.addSubview(accountAmountTF)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(onOffToggle)
        
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
