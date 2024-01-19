//
//  AccountsTransferCell.swift
//  CoinTail
//
//  Created by Eugene on 27.10.23.
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


protocol TransferCellDelegate: AnyObject {
    func cell(didUpdateTransferAmount amount: String?)
}

final class TransferCell: UICollectionViewCell {
    
    static let id = "TransferCell"
    
    weak var transferCellDelegate: TransferCellDelegate?

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
        label.textColor = .black
        
        return label
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        
        textField.tintColor = .clear
        textField.textColor = .black
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.keyboardType = .decimalPad
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        amountTextField.delegate = self
        
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(menuLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(amountTextField)
        contentView.addSubview(accountNameLabel)
        
        contentView.easy.layout([
            Edges()
        ])
        
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
    
    @objc func handleCellTap() {
        amountTextField.becomeFirstResponder()
    }
    
    func amountTapGesture() {
        let amountTFTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap))
        
        addGestureRecognizer(amountTFTapGesture)
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width,
            height: 72
        )
    }
    
}
