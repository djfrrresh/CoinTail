//
//  CreateCategoryVC.swift
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
import RealmSwift


final class CreateCategoryVC: BasicVC {
    
    var categoryID: ObjectId?
    var isToggleOn: Bool = false
    var isEditingSubcategory: Bool = false
    var categoryName: String?
    var categoryIcon: String?
    var segmentTitle: String?
    var mainCategoryName: String? {
        didSet {
            guard let mainCategoryName = mainCategoryName else { return }
            let indexPathToUpdate = IndexPath(item: 3, section: 0)
            
            updateCell(at: indexPathToUpdate, text: mainCategoryName)
        }
    }
    
    let deleteCategoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "cancelAction")
        button.layer.cornerRadius = 16
        button.setTitle("Delete category".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.isHidden = true
        
        return button
    }()
    
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
    
    init(categoryID: ObjectId, segmentTitle: String) {
        self.categoryID = categoryID
        self.segmentTitle = segmentTitle
        self.isEditingSubcategory = true
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Edit category".localized()
        
        guard let category = Categories.shared.getGeneralCategory(for: categoryID) else { return }
        
        setupUI(with: category)
    }
    
    public required init(segmentTitle: String) {
        self.segmentTitle = segmentTitle
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Create a category".localized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = "Back".localized()
                        
        createCategoryCV.delegate = self
        
        createCategoryCV.dataSource = self
                        
        createCategorySubviews()
        createCategoryNavBar()
        createCategoryTargets()
    }
 
}
