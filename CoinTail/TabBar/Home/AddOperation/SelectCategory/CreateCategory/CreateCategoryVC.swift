//
//  CreateCategoryVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


class CreateCategoryVC: BasicVC, UIGestureRecognizerDelegate {
    
    // Передача новой категории в SelectCategoryVC
    weak var addNewCategoryDelegate: AddNewCategory?
    
    // Картинки для создания категории
    static let newImages = Categories.shared.createCategoryImages
    
    var selectedColor: UIColor?
    var segmentTitle: String?
    var addOperationVCSegment: RecordType {
        RecordType(rawValue: segmentTitle ?? "Expense") ?? .expense
    }
    
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
        cv.register(CreateCategoryCell.self, forCellWithReuseIdentifier: CreateCategoryCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.allowsMultipleSelection = false
        
        return cv
    }()
    
    let titleLabel = UILabel(
        text: "Add new category".localized(),
        alignment: .center,
        color: .black
    )
    let errorLabel: UILabel = {
        let label = UILabel(
            text: "Missing category name or no icon selected!".localized(),
            alignment: .center,
            color: .black
        )
        label.isHidden = true
        
        return label
    }()

    let categoryTF = UITextField(
        background: .white,
        keyboard: .default,
        placeholder: "Type a category name".localized()
    )
    
    // Выбранная картинка, передается в делегате
    var selectedCategoryImage = UIImage(systemName: newImages[0])

    let addButton = UIButton(
        name: "Add category".localized(),
        background: .white,
        textColor: .black
    )
    let parentalCategoryButton = UIButton(
        name: "Add parental category".localized(),
        background: .white,
        textColor: .black
    )
    let selectColorButton = UIButton(
        name: "Select color".localized(),
        background: .white,
        textColor: .black
    )
    
    public required init(segmentTitle: String) {
        self.segmentTitle = segmentTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = .clear
        self.view.isOpaque = false // Выключает прозрачность view
                        
        createCategoryCV.delegate = self
        
        createCategoryCV.dataSource = self
                        
        createTargets() // Таргеты для кнопок
        setPopupElements() // Расположение элементов всплывающего окна
    }
 
}
