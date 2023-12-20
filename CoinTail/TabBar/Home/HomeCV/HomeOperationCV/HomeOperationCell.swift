//
//  HomeGlobalCVCell.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

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
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(operationsCV)
        
        operationsCV.easy.layout([
            Edges()
        ])
    }
    
    // Проверка на сегодняшнюю дату
    func checkToday(date: Date, textField: UITextField) {
        let headerDF:  DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "dd/MM/yyyy"
            
            return formatter
        }()
        
        if (headerDF.string(from: date) == headerDF.string(from: Date())) {
            textField.text = "Today \(headerDF.string(from: date))"
        } else {
            textField.text = headerDF.string(from: date)
        }
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
