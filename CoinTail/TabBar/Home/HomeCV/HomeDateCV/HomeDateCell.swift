//
//  HomeDateCell.swift.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import EasyPeasy


protocol SelectedSegmentDate: AnyObject {
    func selectedPeriod(_ period: DatePeriods)
    func sendSegment(_ segment: RecordType, index: Int)
}

final class HomeDateCell: UICollectionViewCell {
    
    static let id = "HomeDateCell"
    
    weak var segmentDateDelegate: SelectedSegmentDate?
        
    let periods: [String] = [
        "All the time".localized(),
        "Year".localized(),
        "3 months".localized(),
        "Month".localized()
    ]
    
    let typeSwitcher: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            RecordType.allOperations.rawValue.localized(),
            RecordType.income.rawValue.localized(),
            RecordType.expense.rawValue.localized()
        ])
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    var period: DatePeriods? {
        didSet {
            dateCV.reloadData()
        }
    }
    
    let dateCV: UICollectionView = {
        let dateLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            
            return layout
        }()

        let cv = UICollectionView(frame: .zero, collectionViewLayout: dateLayout)
        cv.register(DateCVCell.self, forCellWithReuseIdentifier: DateCVCell.id)
        cv.scrollIndicatorInsets = .zero
        cv.backgroundColor = .clear
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        dateCV.delegate = self
        dateCV.dataSource = self
        
        typeSwitcher.addTarget(self, action: #selector(switchAction), for: .valueChanged)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(dateCV)
        contentView.addSubview(typeSwitcher)
        
        typeSwitcher.easy.layout([
            Left(16),
            Right(16),
            Top(24)
        ])

        dateCV.easy.layout([
            Left(),
            Right(),
            Height(40),
            Top(16).to(typeSwitcher, .bottom)
        ])
    }
    
    @objc func switchAction() {
        var segment: RecordType

        switch typeSwitcher.selectedSegmentIndex {
        case 0:
            segment = RecordType.allOperations
        case 1:
            segment = RecordType.income
        case 2:
            segment = RecordType.expense
        default:
            segment = RecordType.allOperations
        }
        
        segmentDateDelegate?.sendSegment(segment, index: typeSwitcher.selectedSegmentIndex)
    }
    
    static func size() -> CGSize {
        let dateCVHeight: CGFloat = 40
        let typeSwitcherHeight: CGFloat = 40
        let padding: CGFloat = 16
        
        let sumHeight = dateCVHeight + typeSwitcherHeight + padding
        
        return .init(
            width: UIScreen.main.bounds.width,
            height: sumHeight
        )
    }
    
}
