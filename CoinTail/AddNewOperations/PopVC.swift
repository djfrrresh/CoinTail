//
//  AddNewOperationPopVC.swift
//  CoinTail
//
//  Created by Eugene on 27.10.22.
//

import UIKit
import EasyPeasy


class AddNewOperationPopVC: UIViewController {
    
    weak var categoryDelegate: СategorySendTextImage? // Переменная делегата, связывающая протокол с собой. Передает категорию из таблицы с категориями в текст кнопки
        
    var categories: [String]
    var categoryImages: [String]
    
    var collectionView: UICollectionView?
        
    public required init(_ categories: [String], _ categoryImages: [String]) {
        self.categories = categories
        self.categoryImages = categoryImages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.view.backgroundColor = .white.withAlphaComponent(1)
        self.navigationController?.navigationBar.tintColor = .black
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 32
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: 70, height: 70)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.id)
        collectionView.delegate = self // Реагирование на события
        collectionView.dataSource = self // Здесь подаются данные
        
        self.view.addSubview(collectionView)
        collectionView.easy.layout([Top(90), Bottom(), Left(32), Right(32)])
    }
}
