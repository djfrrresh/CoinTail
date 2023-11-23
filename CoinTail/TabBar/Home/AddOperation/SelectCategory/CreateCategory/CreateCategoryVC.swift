//
//  CreateCategoryVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


class CreateCategoryVC: BasicVC {
    
    var categoryID: ObjectId?
    var categoryName: String?
    var mainCategoryName: String? {
        didSet {
            guard let mainCategoryName = mainCategoryName else { return }
            let indexPathToUpdate = IndexPath(item: 3, section: 0)
            
            updateCell(at: indexPathToUpdate, text: mainCategoryName)
        }
    }
    var categoryIcon: String?
    var isToggleOn: Bool = false
    
    var segmentTitle: String?
    var addOperationVCSegment: RecordType {
        RecordType(rawValue: segmentTitle ?? "Expense") ?? .expense
    }
    
    let createCategoryCV: UICollectionView = {
        let createCategoryLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0

            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createCategoryLayout)
        cv.backgroundColor = .clear
        cv.register(CreateCategoryCell.self, forCellWithReuseIdentifier: CreateCategoryCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.delaysContentTouches = true
        
        return cv
    }()
    
    public required init(segmentTitle: String) {
        self.segmentTitle = segmentTitle
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create category".localized()
        self.navigationItem.backButtonTitle = "Back".localized()
                        
        createCategoryCV.delegate = self
        
        createCategoryCV.dataSource = self
                        
        createCategorySubviews()
        createCategoryNavBar()
    }
 
}
