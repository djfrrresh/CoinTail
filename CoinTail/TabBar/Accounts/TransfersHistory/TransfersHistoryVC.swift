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
    
    let emptyAccountsView = UIView()
    
    let monocleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "monocleEmoji")
        
        return imageView
    }()
    
    let noAccountsLabel: UILabel = {
        let label = UILabel()
        label.text = "You have no transfer transactions".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Once you transfer money from one account to another – you can check transfer history here".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(named: "secondaryTextColor")
        
        return label
    }()
    
    let addAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Transfer money".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return button
    }()
    
    let transfersCV: UICollectionView = {
        let transfersLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 4
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: transfersLayout)
        cv.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0) // Отступ сверху
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
        
        self.title = "Transfers history".localized()
        
        transfersCV.delegate = self
        
        transfersCV.dataSource = self
        
        transfersSubviews()
        emptyTransfersSubviews()
        transferButtonTargets()
    }
    
}
