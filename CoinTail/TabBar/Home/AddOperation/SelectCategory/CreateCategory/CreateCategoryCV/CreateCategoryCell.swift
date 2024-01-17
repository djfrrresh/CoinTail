//
//  CreateCategoryCell.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
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


protocol CreateCategoryCellDelegate: AnyObject {
    func cell(didUpdateCategoryName name: String?)
    func cell(didUpdateCategoryIcon icon: String?)
    func cell(didUpdateOnOffToggle isOn: Bool)
}

final class CreateCategoryCell: UICollectionViewCell {
    
    static let id = "CreateCategoryCell"
    
    weak var createCategoryCellDelegate: CreateCategoryCellDelegate?

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
    let parentalCategoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.textColor = UIColor(named: "secondaryTextColor")

        return label
    }()
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "SFProText-Regular", size: 17)

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
        uiSwitch.isOn = false
        
        return uiSwitch
    }()
    
    let categoryNameTF: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return textField
    }()
    let categoryIconTF: EmojiTextField = {
        let textField = EmojiTextField()
        textField.font = UIFont(name: "SFProText-Regular", size: 24)
        textField.tintColor = .clear
        
        return textField
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        categoryNameTF.delegate = self
        categoryIconTF.delegate = self
        
        onOffToggle.addTarget(self, action: #selector(switchValueChanged), for: UIControl.Event.valueChanged)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(menuLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(categoryNameTF)
        contentView.addSubview(emojiLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(onOffToggle)
        contentView.addSubview(parentalCategoryLabel)
        contentView.addSubview(categoryIconTF)
        
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
        
        onOffToggle.easy.layout([
            Right(16),
            CenterY()
        ])
        
        categoryNameTF.easy.layout([
            Left(16),
            Right(16),
            Top(),
            Bottom()
        ])
        
        emojiLabel.easy.layout([
            Right(4).to(chevronImageView, .left),
            CenterY()
        ])
        
        parentalCategoryLabel.easy.layout([
            Right(4).to(chevronImageView, .left),
            Left(16).to(menuLabel, .right),
            CenterY()
        ])
        
        categoryIconTF.easy.layout([
            Right(4).to(chevronImageView, .left),
            CenterY()
        ])
    }
    
    func isSeparatorLineHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
    func updateSubMenuLabel(_ labelText: String) {
        parentalCategoryLabel.text = labelText
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
            createCategoryCellDelegate?.cell(didUpdateOnOffToggle: sender.isOn)
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 44
        )
    }
    
}
