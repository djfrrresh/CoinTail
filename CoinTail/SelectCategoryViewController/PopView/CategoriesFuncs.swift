//
//  PopFuncs.swift
//  CoinTail
//
//  Created by Eugene on 17.11.22.
//

import UIKit
import EasyPeasy


extension CustomPopVC {
    
    // Вывести ошибку если имя категории пустое
    func addCategory() -> Bool {
        if categoryTextField.text?.isEmpty == true {
            errorLabel.isHidden = false
            return false
        } else {
            errorLabel.isHidden = true
            return true
        }
    }

    // Задать расположение элементов
    func setConstraints() {
        view.addSubview(self.popUpView)
        self.popUpView.addSubview(self.titleLabel)
        self.popUpView.addSubview(self.categoryTextField)
        self.popUpView.addSubview(self.errorLabel)
        self.popUpView.addSubview(self.addButton)
        
        self.popUpView.easy.layout(CenterX(),CenterY(), Left(20), Right(20), Height(300))
        self.titleLabel.easy.layout(CenterX(), Top(10))
        self.categoryTextField.easy.layout(Top(10).to(titleLabel, .bottom), Height(40), Left(20), Right(20))
        self.errorLabel.easy.layout(Bottom(10).to(addButton, .top), CenterX(), Height(50))
        self.addButton.easy.layout(Bottom(32), CenterX(), Left(32), Right(16), Height(64))
    }
    
    // Задать настройки для элементов
    func setObjectsSettings() {
        self.errorLabel.isHidden = true
        self.errorLabel.text = "Missing category name or no icon selected!"
                
        self.titleLabel.text = "Add new category"
        self.categoryTextField.autocorrectionType = .no
        self.categoryTextField.backgroundColor = .white
        self.categoryTextField.placeholder = "Print a category name"
        self.categoryTextField.layer.borderColor = UIColor.black.cgColor
        self.categoryTextField.layer.cornerRadius = 8
        self.categoryTextField.layer.borderWidth = 1
        self.categoryTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.categoryTextField.frame.height))
        self.categoryTextField.leftViewMode = .always
                
        self.addButton.setTitle("Add", for: .normal)
        self.addButton.backgroundColor = .white
        self.addButton.layer.cornerRadius = 8
        self.addButton.layer.borderWidth = 1
        self.addButton.setTitleColor(.black, for: .normal)
        self.addButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    // Создание ячейки
    func createCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize.init(width: 50, height: 50)
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .infinite, collectionViewLayout: flowLayout)
        guard let collectionView = collectionView else {return}
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        collectionView.scrollIndicatorInsets = .zero
        popUpView.addSubview(collectionView)
        collectionView.easy.layout(Bottom().to(errorLabel, .top), Left(), Right(), Top(10).to(categoryTextField, .bottom))
    }
    
}
