//
//  SelectCategoryVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit


//TODO: категории не разбиваются по типам операции
class SelectCategoryVC: BasicVC {
    
    let categories: [CategoryClass] = Categories.shared.categories
    
    weak var subcategoryDelegate: SendSubcategoryID? // Передает подкатегорию
    weak var categoryDelegate: SendCategoryID? // Передает подкатегорию
    
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
    
    public required init(segmentTitle: String, isParental: Bool) {
        self.rawSegmentType = segmentTitle
        self.isParental = isParental
        
        newCategoryButton.isHidden = isParental
        
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
        
        var title: String = ""
        switch operationSegmentType {
        case .expense:
            title = "Expense categories".localized()
        case .income:
            title = "Income categories".localized()
        case .allOperations:
            return
        }
        self.title = title
        
        selectCategoryCV.delegate = self
        
        selectCategoryCV.dataSource = self
        
        newCategoryButton.addTarget(self, action: #selector(goToCreateCategoryVC), for: .touchUpInside)
        
        selectCategorySubviews()
    }
    
}
