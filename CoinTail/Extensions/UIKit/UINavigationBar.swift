//
//  UINavigationBar.swift
//  CoinTail
//
//  Created by Eugene on 14.12.23.
//

import UIKit
import EasyPeasy


class CustomNavigationBar: UINavigationBar {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "SFProText-Regular", size: 17)

        return label
    }()
    
    let customButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.tintColor = UIColor(named: "primaryAction")
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(customButton)
        addSubview(subTitleLabel)
        
        titleLabel.easy.layout([
            Left(16),
            Right(72),
            Bottom()
        ])
        
        customButton.easy.layout([
            Height(32),
            Width(32),
            CenterY().to(titleLabel),
            Right(16)
        ])
        
        subTitleLabel.easy.layout([
            Left(16),
            Right(16),
            Bottom(12).to(titleLabel, .top)
        ])
    }
    
}
