//
//  PremiumAdvantagesCell.swift
//  CoinTail
//
//  Created by Eugene on 07.12.23.
//

import UIKit
import EasyPeasy


final class PremiumAdvantagesCell: UICollectionViewCell {
    
    static let id = "PremiumAdvantagesCell"

    var advantagesCellData: [AdvantagesData] = []
    
    lazy private var advantagesCV: UICollectionView = {
        let plansLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 24
            
            return layout
        }()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: plansLayout)
        cv.backgroundColor = .clear
        cv.register(AdvantagesCell.self, forCellWithReuseIdentifier: AdvantagesCell.id)
        
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = false
        cv.isScrollEnabled = false
        
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "arrowColor")?.cgColor
        contentView.layer.cornerRadius = 16
        
        advantagesCV.dataSource = self
        
        advantagesCV.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(advantagesCV)

        advantagesCV.easy.layout([
            Edges()
        ])
    }
    
    static func size(data: [AdvantagesData]) -> CGSize {
        var collectionHeight: CGFloat = CGFloat(24 * (data.count - 1))
        
        for moc in data {
            collectionHeight += AdvantagesCell.size(data: moc).height
        }
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: collectionHeight + 16 * 2
        )
    }
    
}
