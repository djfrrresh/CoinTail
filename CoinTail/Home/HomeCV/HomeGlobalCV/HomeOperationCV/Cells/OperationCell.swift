//
//  OperationCell.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import EasyPeasy


final class OperationCVCell: UICollectionViewCell {
    
    static let id = "OperationCVCell"
    
    var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    var backImage: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
         
    var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return imageView
    }()
    var arrowImage: UIImageView = {
        let image = UIImageView()
        // Иконка стрелки у суммы
        image.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.gray
        return image
    }()

    var amountLabel: UILabel = getAmountLabel()
    var categoryLabel: UILabel = getCategoryLabel()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backView)
        backView.addSubview(backImage)
        backView.addSubview(categoryLabel)
        backView.addSubview(amountLabel)
        backView.addSubview(arrowImage)
        
        backImage.addSubview(categoryImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.easy.layout([
            Height(68),
            Left(0),
            Right(0),
            CenterY()
        ])
        
        backImage.easy.layout([
            Height(56),
            Width(56),
            CenterY(),
            Left()
        ])

        categoryImage.easy.layout([
            CenterY(),
            CenterX(),
            Height(44),
            Width(44)
        ])
        
        arrowImage.easy.layout([
            CenterY(),
            Right(8),
            Height(24),
            Width(16)
        ])

        categoryLabel.easy.layout([
            Height(16),
            Left(8).to(backImage),
            Right(8).to(amountLabel, .left),
            CenterY()
        ])
        
        amountLabel.easy.layout([
            Height(16),
            Right(16).to(arrowImage, .left),
            CenterY()
        ])
    }
    
    static func getCategoryLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }
    
    static func getAmountLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }
    
    static func size(data: Record) -> CGSize {
        let imageHeight: CGFloat = 56
        let amount = getAmountLabel()
        amount.text = String(data.amount)
        
        // sizeThatFits вычисляет и возвращает окончательный размер
        let amountWidth = amount.sizeThatFits(.init(width: 0, height: 0)).width

        let textWidth: CGFloat = UIScreen.main.bounds.width - 16 - 8 * 2 - amountWidth - 16 - 16 - 24
        let label = getCategoryLabel()
        
        label.text = data.categoryText
        let labelHeight = label.sizeThatFits(.init(width: textWidth, height: 0)).height
        
        // Конечный размер ячейки определяется по высоте backImage или высоте текста категории
        let cellHeight = imageHeight > labelHeight ? imageHeight + 7 * 2 : labelHeight + 7 * 2
        
        return .init(
            width: UIScreen.main.bounds.width - 16 - 16,
            height: cellHeight
        )
    }
    
    // Ставит цвет текста в зависимости от типа операции
    func setAmountColor(recordType: RecordType, amountLabel: UILabel) {
        switch recordType {
        case .expense:
            amountLabel.textColor = .systemRed
        case .income:
            amountLabel.textColor = .systemGreen
        default:
            amountLabel.textColor = .black
        }
    }

}
