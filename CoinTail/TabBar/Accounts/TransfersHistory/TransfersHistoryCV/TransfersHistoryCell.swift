//
//  TransfersHistoryCell.swift
//  CoinTail
//
//  Created by Eugene on 12.09.23.
//

import UIKit
import EasyPeasy


class TransfersHistoryCell: UICollectionViewCell {
    
    static let id = "TransfersHistoryCell"
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        imageView.image = UIImage(systemName: "arrow.right")
        
        return imageView
    }()
    
    let headerDF: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        return formatter
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let sourceAccountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        
        return label
    }()
    let targetAccountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        
        return label
    }()
    let amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
                
        addSubview(backView)
        addSubview(dateLabel)
        
        backView.addSubview(amountLabel)
        backView.addSubview(arrowImage)
        backView.addSubview(sourceAccountLabel)
        backView.addSubview(targetAccountLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Left(),
            Right(),
            Bottom(),
            Height(60)
        ])
        
        sourceAccountLabel.easy.layout([
            CenterY(),
            Left(16)
        ])
        
        targetAccountLabel.easy.layout([
            CenterY(),
            Right(16)
        ])
        
        amountLabel.easy.layout([
            CenterX(),
            CenterY(-10)
        ])
        
        dateLabel.easy.layout([
            Top(),
            Left()
        ])
        
        arrowImage.easy.layout([
            CenterX(),
            CenterY(10)
        ])
    }
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: 80
        )
    }
    
}
