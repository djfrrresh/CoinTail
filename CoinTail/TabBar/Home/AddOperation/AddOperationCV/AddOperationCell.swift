//
//  AddOperationCell.swift
//  CoinTail
//
//  Created by Eugene on 15.11.23.
//

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

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "arrowColor")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let operationAmountTF: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.placeholder = "Amount".localized()
        
        return textField
    }()
    let operationDescriptionTF: UITextView = {
        let textField = UITextView()
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.text = "Add a comment to your transaction".localized()
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
        
        backgroundColor = .clear
        
        operationAmountTF.delegate = self
        operationDescriptionTF.delegate = self
        dateTF.delegate = self
                
        addSubview(backView)
        
        backView.addSubview(chevronImageView)
        backView.addSubview(separatorView)
        backView.addSubview(operationAmountTF)
        backView.addSubview(menuLabel)
        backView.addSubview(subMenuLabel)
        backView.addSubview(operationDescriptionTF)
        backView.addSubview(dateTF)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout(Edges())

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
            CenterY()
        ])
        
        subMenuLabel.easy.layout([
            CenterY(),
            Right(4).to(chevronImageView, .left),
            Left(16).to(menuLabel, .right)
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
    
}
