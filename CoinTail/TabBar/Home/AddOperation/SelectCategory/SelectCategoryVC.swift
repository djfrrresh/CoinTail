//
//  SelectCategoryVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


class SelectCategoryVC: BasicVC {
    
    let categories = Categories.shared.categories
    
    weak var subcategoryDelegate: SendSubcategoryID? // Передает подкатегорию
    weak var categoryDelegate: SendCategoryID? // Передает подкатегорию
    
    var isParental: Bool = false
    var section: Int?
            
    let selectCategoryCV: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.backgroundColor = .clear
        cv.register(SelectCategoryCell.self, forCellWithReuseIdentifier: SelectCategoryCell.id)
        cv.register(SelectCategoryCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SelectCategoryCell.id)
        
        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        
        return cv
    }()
        
    let newCategoryButton = UIButton(
        name: "+",
        background: .white,
        textColor: .black
    )
            
    var rawSegmentType: String?
    var operationSegmentType: RecordType {
        RecordType(rawValue: rawSegmentType ?? "Expense") ?? .expense
    }
    
    public required init(segmentTitle: String, isParental: Bool) {
        // Получаем тип операции из AddOperationVC для отображения категорий
        self.rawSegmentType = segmentTitle
        self.isParental = isParental
        
        newCategoryButton.isHidden = isParental
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select category".localized()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        selectCategoryCV.delegate = self
        
        selectCategoryCV.dataSource = self
        
        self.view.addSubview(newCategoryButton)
        self.view.addSubview(selectCategoryCV)
        
        newCategoryButton.easy.layout([
            Bottom(20).to(self.view.safeAreaLayoutGuide, .bottom),
            Right(20).to(self.view.safeAreaLayoutGuide, .right),
            Height(64),
            Width(64)
        ])
        
        selectCategoryCV.easy.layout([
            Top().to(self.view.safeAreaLayoutGuide, .top),
            Bottom(16).to(newCategoryButton, .top),
            Left(16),
            Right(16)
        ])
            
        newCategoryButton.addTarget(self, action: #selector(goToCreateCategoryVC), for: .touchUpInside)
    }
    
}
