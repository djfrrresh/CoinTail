//
//  CreateCategoryVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


class CreateCategoryVC: BasicVC, UIGestureRecognizerDelegate {
    
    // Всплывающее окно добавления новой категории
    let popUpView: UIView = {
       let popUp = UIView()
        popUp.layer.cornerRadius = 15
        popUp.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        popUp.layer.borderWidth = 1
        popUp.layer.masksToBounds = true
        popUp.layer.borderColor = UIColor.black.cgColor
        return popUp
    }()
    
    let createCategoryCV: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 1
            layout.itemSize = CGSize(width: 50, height: 50)
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cv.scrollIndicatorInsets = .zero
        cv.register(SelectCategoryCVCell.self, forCellWithReuseIdentifier: SelectCategoryCVCell.id)
        
        cv.showsHorizontalScrollIndicator = false
        cv.allowsMultipleSelection = false
        
        return cv
    }()
    
    let titleLabel = UILabel(
        text: "Add new category",
        alignment: .center,
        color: .black
    )
    let errorLabel: UILabel = {
        let label = UILabel(
            text: "Missing category name or no icon selected!",
            alignment: .center,
            color: .black
        )
        label.isHidden = true
        return label
    }()

    let categoryTF = UITextField(
        background: .white,
        keyboard: .default,
        placeholder: "Print a category name"
    )
    
    // Выбранная картинка, передается в делегате
    var selectedCategoryImage = UIImage(systemName: newImages[0]) ?? UIImage(systemName: "house")!
    
    // Передача новой категории в SelectCategoryVC
    weak var addNewCategoryDelegate: AddNewCategory?

    let addButton = UIButton(
        name: "Add new category",
        background: .white,
        textColor: .black
    )
    let selectColorButton = UIButton(
        name: "Select color",
        background: .white,
        textColor: .black
    )

    // Картинки для создания категории
    static let newImages = Categories.shared.createCategoryImages
    
    var selectedColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
                        
        createCategoryCV.delegate = self
        createCategoryCV.dataSource = self
                        
        createTargets() // Таргеты для кнопок
        setPopupElements() // Расположение элементов всплывающего окна
    }
 
}
