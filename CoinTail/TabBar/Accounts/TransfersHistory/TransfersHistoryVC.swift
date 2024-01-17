//
//  TransfersHistoryVC.swift
//  CoinTail
//
//  Created by Eugene on 11.09.23.
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
    let transfersEmojiLabel: UILabel = getDataEmojiLabel("🧐")
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
        
        navigationController?.navigationBar.isHidden = false

        self.title = "Transfer history".localized()
        
        transfersCV.delegate = self
        
        transfersCV.dataSource = self
        
        transfersSubviews()
        transferButtonTargets()
        emptyDataSubviews(
            dataView: transfersEmojiLabel,
            noDataLabel: noTransfersLabel,
            dataDescriptionLabel: transfersDescriptionLabel,
            addDataButton: addTransferButton
        )
    }
    
}
