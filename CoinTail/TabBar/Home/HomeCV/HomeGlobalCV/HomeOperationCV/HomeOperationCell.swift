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
    
    var monthSectionsCellData = [MonthSection]() {
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
        cv.register(OperationCVHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OperationCVHeader.id)
        
        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        operationsCV.delegate = self
        operationsCV.dataSource = self
        
        contentView.addSubview(operationsCV)
    }
    
    // Проверка на сегодняшнюю дату
    func checkToday(date: Date, textField: UITextField) {
        let dateFormatter:  DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter
        }()
        
        if (dateFormatter.string(from: date) == dateFormatter.string(from: Date())) {
            textField.text = "Today \(dateFormatter.string(from: date))"
        } else {
            textField.text = dateFormatter.string(from: date)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        operationsCV.easy.layout(Edges())
    }
    
    static func size(data: [MonthSection]) -> CGSize {
        var height: CGFloat = 0
        
        // Размер общей коллекции вычисляется по размеру каждой ячейки
        for monthSection in data {
            for record in monthSection.records {
                height += OperationCVCell.size(data: record).height
            }
            height += 32
        }
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: height
        )
    }
}
