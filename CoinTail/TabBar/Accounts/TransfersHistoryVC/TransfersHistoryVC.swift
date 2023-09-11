//
//  TransfersHistoryVC.swift
//  CoinTail
//
//  Created by Eugene on 11.09.23.
//

import UIKit


class TransfersHistoryVC: BasicVC {
    
    var transfers = [TransferHistory]() {
        didSet {
            transfersCV.reloadData()
        }
    }
    
    let transfersCV: UICollectionView = {
        let transfersLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 8
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: transfersLayout)
        cv.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.backgroundColor = .clear
        cv.register(TransfersHistoryCell.self, forCellWithReuseIdentifier: TransfersHistoryCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sortTransfers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transfers history".localized()
        
        transfersCV.delegate = self
        
        transfersCV.dataSource = self
        
        transfersSubviews()
    }
    
}
