//
//  SelectCategoryVC.swift
//  CoinTail
//
//  Created by Eugene on 15.06.23.
//

import UIKit
import EasyPeasy


class SelectCategoryVC: BasicVC {
    
    weak var categoryDelegate: SendСategory? // Передает категорию
    
    let selectCategoryCV: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 48
            layout.minimumInteritemSpacing = 1
            layout.itemSize = CGSize(width: 70, height: 70)
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(SelectCategoryCVCell.self, forCellWithReuseIdentifier: SelectCategoryCVCell.id)
        
        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
        
    let newCategoryButton = UIButton(
        name: "+",
        background: .white,
        textColor: .black
    )
            
    var addOperationVCSegmentType: String?
    var addOperationVCSegment: RecordType {
        RecordType(rawValue: addOperationVCSegmentType ?? "Expense") ?? .expense
    }
    
    public required init(segmentTitle: String) {
        // Получаем тип операции из AddOperationVC для отображения категорий
        self.addOperationVCSegmentType = segmentTitle
        
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

        newCategoryButton.removeTarget(nil, action: nil, for: .allEvents)

        selectCategoryCV.delegate = self
        
        selectCategoryCV.dataSource = self
        
        self.view.addSubview(newCategoryButton)
        self.view.addSubview(selectCategoryCV)
        
        selectCategoryCV.easy.layout([
            Top(90),
            Bottom(70).to(newCategoryButton, .bottom),
            Left(32),
            Right(32)
        ])
        
        newCategoryButton.easy.layout([
            Bottom(20).to(self.view.safeAreaLayoutGuide, .bottom),
            Right(20).to(self.view.safeAreaLayoutGuide, .right),
            Height(64),
            Width(64)
        ])
            
        newCategoryButton.addTarget(self, action: #selector(goToCreateCategoryVC), for: .touchUpInside)
    }
    
}
