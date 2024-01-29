//
//  AddOperationCell.swift
//  CoinTail
//
//  Created by Eugene on 15.11.23.
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


protocol AddOperationCellDelegate: AnyObject {
    func cell(didUpdateOperationAmount amount: String?)
    func cell(didUpdateOperationDescription description: String?)
    func cell(didUpdateOperationDate date: Date)
}

final class AddOperationCell: UICollectionViewCell {
    
    static let id = "AddOperationCell"
    
    weak var addOperationCellDelegate: AddOperationCellDelegate?

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "arrowColor")
        
        return view
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let subMenuLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")
        label.textAlignment = .right
        
        return label
    }()
    let repeatOperationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        label.text = "Repeat previous transaction".localized()
        label.textAlignment = .left
        
        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    let repeatIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "arrow.clockwise")
        imageView.tintColor = UIColor(named: "primaryAction")
        
        return imageView
    }()
    
    let operationAmountTF: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.placeholder = "Amount".localized()
        textField.keyboardType = .decimalPad
        
        return textField
    }()
    let operationDescriptionTF: UITextView = {
        let textField = UITextView()
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.textColor = UIColor(named: "secondaryTextColor")
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    static let todayText = "Today".localized()
    let dateTF: UITextField = {
        let textField = UITextField()
        let todayString = operationDF.string(from: Date())
        textField.text = "\(todayText) \(todayString)"
        textField.textAlignment = .right
        textField.inputView = operationDatePicker
        textField.textColor = UIColor(named: "secondaryTextColor")
        textField.inputAccessoryView = dateToolbar()
        textField.tintColor = .clear
        
        return textField
    }()
    
    static let operationDF: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter
    }()
    
    static let operationDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.timeZone = NSTimeZone.local
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white

        operationAmountTF.delegate = self
        operationDescriptionTF.delegate = self
        dateTF.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
        contentView.addSubview(operationAmountTF)
        contentView.addSubview(subMenuLabel)
        contentView.addSubview(menuLabel)
        contentView.addSubview(operationDescriptionTF)
        contentView.addSubview(dateTF)
        contentView.addSubview(repeatIconImageView)
        contentView.addSubview(repeatOperationLabel)
        
        contentView.easy.layout([
            Edges()
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
        
        menuLabel.easy.layout([
            Left(16),
            Right(16).to(subMenuLabel, .left),
            CenterY()
        ])
        
        subMenuLabel.easy.layout([
            CenterY(),
            Right(4).to(chevronImageView, .left)
        ])
        
        operationAmountTF.easy.layout([
            Left(16),
            Right(16),
            Top(),
            Bottom()
        ])
        
        operationDescriptionTF.easy.layout([
            Left(16),
            Right(16),
            Top(),
            Bottom()
        ])
        
        dateTF.easy.layout([
            Left(16),
            Right(4).to(chevronImageView, .left),
            Top(),
            Bottom()
        ])
        
        repeatIconImageView.easy.layout([
            Height(32),
            Width(32),
            Left(16),
            CenterY()
        ])
        
        repeatOperationLabel.easy.layout([
            Left(8).to(repeatIconImageView, .right),
            Right(16),
            CenterY()
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    func updateSubMenuLabel(_ labelText: String) {
        subMenuLabel.text = labelText
    }
    
    private static func dateToolbar() -> UIToolbar {
        let toolbar: UIToolbar = {
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            toolBar.tintColor = .systemBlue

            let doneButton = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: nil,
                action: #selector(doneButtonAction)
            )
            toolBar.setItems([doneButton], animated: true)

            return toolBar
        }()

        return toolbar
    }
    
    @objc func doneButtonAction() {
        let date = AddOperationCell.operationDatePicker.date
        let formatter = AddOperationCell.operationDF
        let dateString = formatter.string(from: date)

        dateTF.text = dateString == formatter.string(from: Date()) ? "\(AddOperationCell.todayText) \(dateString)" : dateString
        
        addOperationCellDelegate?.cell(didUpdateOperationDate: date)

        self.endEditing(true)
    }
    
    @objc func handleCellTap() {
        dateTF.becomeFirstResponder()
    }
    
    func dateTapGesture() {
        let dateTFTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap))
        
        addGestureRecognizer(dateTFTapGesture)
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 44
        )
    }
    
    static func descriptionCellSize() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 80
        )
    }
    
    static func repeatOperationCellSize() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 52
        )
    }
    
}
