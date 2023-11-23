//
//  SelectCategoryVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import RealmSwift


protocol SendCategoryID: AnyObject {
    func sendCategoryData(id: ObjectId)
}

class SelectCategoryVC: BasicVC {
    
    var categories: [CategoryProtocol] {
        get {
            var categories = [CategoryProtocol]()

            if categoryID == nil {
                switch operationSegmentType {
                case .expense:
                    categories = RealmService.shared.categoriesArr.filter { $0.type == RecordType.expense.rawValue }
                case .income:
                    categories = RealmService.shared.categoriesArr.filter { $0.type == RecordType.income.rawValue }
                case .allOperations:
                    return categories
                }
            } else {
                guard let categoryID = categoryID,
                      let parentalCategory = Categories.shared.getCategory(for: categoryID) else { return categories }
                
                // Родительская категория
                categories.append(parentalCategory)
                
                // Подкатегории
                for subcategoryID in parentalCategory.subcategories {
                    if let subcategory = Categories.shared.getSubcategory(for: subcategoryID) {
                        categories.append(subcategory)
                    }
                }
            }
            
            return categories
        }
    }
    
    weak var categoryDelegate: SendCategoryID?
    
    var categoryID: ObjectId?
    
    var filteredData = [CategoryClass]()
    var isSearching: Bool = false
    var isParental: Bool = false
            
    let selectCategoryCV: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.layer.cornerRadius = 12
        cv.register(SelectCategoryCell.self, forCellWithReuseIdentifier: SelectCategoryCell.id)
        
        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    let categorySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type any category name".localized()
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        return searchBar
    }()
        
    let newCategoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Create a category".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
            
    var rawSegmentType: String?
    var operationSegmentType: RecordType {
        RecordType(rawValue: rawSegmentType ?? "Expense") ?? .expense
    }
    
    public required init(segmentTitle: String, isParental: Bool, categoryID: ObjectId?) {
        self.rawSegmentType = segmentTitle
        self.isParental = isParental
        self.categoryID = categoryID
                
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectCategoryCV.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.backButtonTitle = "Back".localized()

        selectCategoryCV.delegate = self
        
        selectCategoryCV.dataSource = self
        
        newCategoryButton.addTarget(self, action: #selector(goToCreateCategoryVC), for: .touchUpInside)
        
        selectCategorySubviews()
        setTitle()
    }
    
}
