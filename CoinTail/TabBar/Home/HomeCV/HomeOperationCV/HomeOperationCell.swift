//
//  HomeGlobalCVCell.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
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
import EasyPeasy


final class HomeOperationCell: UICollectionViewCell {
    
    static let id = "HomeOperationCell"
    
    weak var pushVCDelegate: PushVC?
    
    var monthSectionsCellData = [OperationsDaySection]() {
        didSet {
            operationsCV.reloadData()
        }
    }
    var segmentType: RecordType = .allOperations

    let noOperationsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "primaryAction")
        button.layer.cornerRadius = 16
        button.setTitle("Add a transaction".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        button.isHidden = true
        
        return button
    }()
    
    let operationsCV: UICollectionView = {
        let operationLayout: UICollectionViewFlowLayout = {
            var layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: operationLayout)
        cv.scrollIndicatorInsets = .zero
        cv.backgroundColor = .clear
        cv.register(OperationCVCell.self, forCellWithReuseIdentifier: OperationCVCell.id)
        cv.register(HomeOperationHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeOperationHeader.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        operationsCV.delegate = self
        operationsCV.dataSource = self
        
        noOperationsButton.addTarget(self, action: #selector(goToAddOperationVC), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(operationsCV)
        contentView.addSubview(noOperationsButton)
        
        operationsCV.easy.layout([
            Edges()
        ])
        
        noOperationsButton.easy.layout([
            Height(52),
            Left(),
            Right(),
            Top(16)
        ])
    }
    
    func noOperationsByType() {
        let records = Records.shared.records.filter { $0.type == segmentType.rawValue }

        if records.isEmpty && segmentType != .allOperations {
            noOperationsButton.isHidden = false
        } else {
            noOperationsButton.isHidden = true
        }
    }
    
    //TODO: button
    @objc func goToAddOperationVC() {
//        let index: Int
//        index = segmentType == .expense ? 0 : 1
//
//        let vc = AddOperationVC(segmentIndex: index)
//        vc.hidesBottomBarWhenPushed = true // Спрятать TabBar
//
//        navigationController?.pushViewController(vc, animated: true)
//
//        // Ставит задержку на время анимации перехода. Чтобы диаграмма не обнулялась раньше времени
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [self] in
//            categorySort = nil
//        }
    }
    
    static func size(data: [OperationsDaySection]) -> CGSize {
        var height: CGFloat = 0
        
        // Размер общей коллекции вычисляется по размеру каждой ячейки
        for monthSection in data {
            for _ in monthSection.records {
                height += OperationCVCell.size().height
            }
            height += 32
        }
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: height
        )
    }
    
}
