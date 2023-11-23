//
//  AccountsTransferCell.swift
//  CoinTail
//
//  Created by Eugene on 27.10.23.
//

import UIKit
import EasyPeasy


protocol TransferCellDelegate: AnyObject {
    func cell(didUpdateTransferAmount amount: String?)
}

final class TransferCell: UICollectionViewCell {
    
    static let id = "TransferCell"
    
    weak var transferCellDelegate: TransferCellDelegate?
        
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
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    let accountNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "black")
        
        return label
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        
        textField.tintColor = .clear
        textField.textColor = UIColor(named: "black")
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        amountTextField.delegate = self
        
        backgroundColor = .clear
        
        addSubview(backView)
                
        backView.addSubview(menuLabel)
        backView.addSubview(separatorView)
        backView.addSubview(amountTextField)
        backView.addSubview(accountNameLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout(Edges())
        
        menuLabel.easy.layout([
            Left(16),
            Top(12)
        ])
        
        separatorView.easy.layout([
            Bottom(),
            Right(),
            Left(16),
            Height(0.5)
        ])
        
        amountTextField.easy.layout([
            Left(16),
            Right(16),
            Top(4).to(menuLabel, .bottom),
            Bottom(12)
        ])
        
        accountNameLabel.easy.layout([
            Left(16),
            Right(16),
            Top(4).to(menuLabel, .bottom),
            Bottom(12)
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    func updateAccountNameLabel(_ labelText: String) {
        accountNameLabel.text = labelText
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width,
            height: 72
        )
    }
    
}

extension TransferCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldString = textField.text, let textFieldRange = Range(range, in: textFieldString) else {
            return false
        }
        let allString = textFieldString.replacingCharacters(in: textFieldRange, with: string)
        
        if textField == amountTextField {
            transferCellDelegate?.cell(didUpdateTransferAmount: allString)
            
            return AmountValidationHelper.isValidInput(textField, shouldChangeCharactersIn: range, replacementString: string)
        } else {
            return false
        }
    }
    
}
