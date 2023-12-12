//
//  TransfersHistoryVC.swift
//  CoinTail
//
//  Created by Eugene on 11.09.23.
//

import UIKit


final class TransfersHistoryVC: BasicVC {

    var transfersDaySections = [DaySectionTransferHistory]() {
        didSet {
            transfersCV.reloadData()
        }
    }
        
    static let noTransfersText = "You have no transfer transactions"
    static let transfersDescriptionText = "Once you transfer money from one account to another - you can check transfer history here"
    
    let noTransfersLabel: UILabel = getNoDataLabel(text: noTransfersText)
    let transfersDescriptionLabel: UILabel = getDataDescriptionLabel(text: transfersDescriptionText)
    let transfersImageView: UIImageView = getDataImageView(name: "monocleEmoji")
    let addTransferButton: UIButton = getAddDataButton(text: "Transfer money")
    
    let transfersCV: UICollectionView = {
        let transfersLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 4
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: transfersLayout)
        cv.contentInset = .init(top: 32, left: 0, bottom: 0, right: 0) // Отступ сверху
        cv.backgroundColor = .clear
        cv.register(TransfersHistoryCell.self, forCellWithReuseIdentifier: TransfersHistoryCell.id)
        cv.register(TransfersHistoryCVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TransfersHistoryCVHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sortTransfers()
        isTransfersEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transfer history".localized()
        
        transfersCV.delegate = self
        
        transfersCV.dataSource = self
        
        transfersSubviews()
        transferButtonTargets()
        emptyDataSubviews(
            dataImageView: transfersImageView,
            noDataLabel: noTransfersLabel,
            dataDescriptionLabel: transfersDescriptionLabel,
            addDataButton: addTransferButton
        )
    }
    
}
