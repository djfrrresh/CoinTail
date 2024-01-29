//
//  HomeCategoryCell.swift
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
import Charts


final class HomeCategoryCell: UICollectionViewCell, ChartViewDelegate {
    
    static let id = "HomeCategoryCell"
    
    var category: CategoryClass?
    
    var categoriesArrCellData = [CategoryClass]() {
        didSet {
            categoriesCV.reloadData()
        }
    }
    // Массив записей в круговой диаграмме
    var pieChartEntries: [ChartDataEntry] = []
    // Цвета для круговой диаграммы
    var pieChartColors: [UIColor] = []
    var segmentType: RecordType = .allOperations
    
    weak var categoryisHiddenDelegate: CategoryIsHiddenDelegate?
    weak var arrowTapDelegate: ArrowTapDelegate?
    weak var sendCategoryDelegate: SendCategoryCellDelegate?
     
    let categoriesCV: UICollectionView = {
        let categoryLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            
            return layout
        }()

        let cv = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)
        cv.scrollIndicatorInsets = .zero
        cv.backgroundColor = .clear
        cv.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.id)

        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.isHidden = true
        
        return cv
    }()

    let openDiagramsView = UIView()

    // Круговая диаграмма
    let pieChart: PieChartView = {
        let pieChart = PieChartView()
        pieChart.isHidden = true
        
        return pieChart
    }()
        
    let periodLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = true
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let amountForPeriodLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.isHidden = true
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return label
    }()
    let openDiagramsLabel: UILabel = getOpenDiagramsLabel()
    let diagramsDescriptionLabel: UILabel = getDiagramsDescriptionLabel()
    
    let diargamsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "align.vertical.bottom.fill")
        imageView.tintColor = UIColor(named: "primaryAction")
        
        return imageView
    }()
    let arrowImageLeft: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.left")
        imageView.tintColor = .black
        imageView.isHidden = true
        
        return imageView
    }()
    let arrowImageRight: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        imageView.isHidden = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        pieChart.delegate = self
        categoriesCV.delegate = self
        
        categoriesCV.dataSource = self
        
        chartsGestureRecognizer() // Обработка нажатий
        configureChart() // Настройки для круговой диаграммы
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(openDiagramsView)
        contentView.addSubview(periodLabel)
        contentView.addSubview(amountForPeriodLabel)
        contentView.addSubview(pieChart)
        contentView.addSubview(arrowImageLeft)
        contentView.addSubview(arrowImageRight)
        contentView.addSubview(categoriesCV)
        contentView.addSubview(diargamsImageView)
        contentView.addSubview(openDiagramsLabel)
        contentView.addSubview(diagramsDescriptionLabel)
        
        contentView.easy.layout([
            Edges()
        ])
        
        openDiagramsView.easy.layout([
            Edges()
        ])
        
        diargamsImageView.easy.layout([
            Height(36),
            Width(36),
            CenterY(),
            Left(16)
        ])
        
        openDiagramsLabel.easy.layout([
            Left(16).to(diargamsImageView, .right),
            Right(16),
            Top(16)
        ])
        
        diagramsDescriptionLabel.easy.layout([
            Left(16).to(diargamsImageView, .right),
            Right(16),
            Bottom(16),
            Top(8).to(openDiagramsLabel, .bottom)
        ])
        
        periodLabel.easy.layout([
            Top(16),
            Left(16)
        ])

        amountForPeriodLabel.easy.layout([
            Top(16),
            Left(8).to(periodLabel, .right),
            Right(16)
        ])
        
        pieChart.easy.layout([
            Top(12).to(periodLabel, .bottom),
            Height(pieChart.isHidden ? 0 : 250),
            Width(pieChart.isHidden ? 0 : 250),
            CenterX()
        ])
        
        arrowImageLeft.easy.layout([
            CenterY().to(pieChart),
            Height(pieChart.isHidden ? 0 : 24),
            Width(pieChart.isHidden ? 0 : 24),
            Left(16)
        ])
        
        arrowImageRight.easy.layout([
            CenterY().to(pieChart),
            Height(pieChart.isHidden ? 0 : 24),
            Width(pieChart.isHidden ? 0 : 24),
            Right(16)
        ])
        
        categoriesCV.easy.layout([
            Left(16),
            Right(16),
            Top(12).to(pieChart, .bottom),
            Bottom(16)
        ])
    }
    
    func arrowIsHidden(left: Bool, right: Bool) {
        arrowImageLeft.isHidden = left
        arrowImageRight.isHidden = right
    }
    
    func chartsUpdate(_ segment: RecordType, records: [RecordClass]) {
        // Добавление записей в диаграмму
        setEntries(segment, records: records)
        // Добавление данных в диаграмму
        updatePieChartData()
    }
    
    // Привязка функций кнопки к диаграммам
    private func chartsGestureRecognizer() {
        let openDiagramsTap = UITapGestureRecognizer(target: self, action: #selector(pieChartAction))
        openDiagramsView.addGestureRecognizer(openDiagramsTap)
        openDiagramsView.isUserInteractionEnabled = true

        let pieChartTap = UITapGestureRecognizer(target: self, action: #selector(pieChartAction))
        pieChart.addGestureRecognizer(pieChartTap)
        pieChart.isUserInteractionEnabled = true
        
        let leftArrowTap = UITapGestureRecognizer(target: self, action: #selector(leftArrowTap))
        arrowImageLeft.addGestureRecognizer(leftArrowTap)
        arrowImageLeft.isUserInteractionEnabled = true
        
        let rightArrowTap = UITapGestureRecognizer(target: self, action: #selector(rightArrowTap))
        arrowImageRight.addGestureRecognizer(rightArrowTap)
        arrowImageRight.isUserInteractionEnabled = true
    }
    
    // Просчитывает размеры ячеек для категорий и делает выравнивание
    static func packBins(data: [CategoryClass]) -> (Int, [CategoryClass]) {
        var bins = [[(CGFloat, CategoryClass)]]()
        var categoriesWidth = [(CGFloat, CategoryClass)]()
        
        for category in data {
            categoriesWidth.append((CategoryCVCell.size(data: category.name, isXmark: false).width, category))
        }
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 16 * 2
        let categoriesCVWidth: CGFloat = screenWidth - 16 * 2
        
        for (width, category) in categoriesWidth {
            var found = false
            
            for bin in bins.indices {
                let spacing: CGFloat = 12
                let currentRowWidth: CGFloat = bins[bin].map({ (w, _) in
                    w
                }).reduce(0, +)
                
                let spacingBetweenCurrentItems: CGFloat = CGFloat(bins[bin].count) * spacing
                if currentRowWidth + width + spacingBetweenCurrentItems <= categoriesCVWidth {
                    bins[bin].append((width, category))
                    
                    found = true
                    
                    break
                }
            }
            
            if !found {
                bins.append([(width, category)])
            }
        }
        
        var categories = [CategoryClass]()
        for bin in bins {
            for (_, cat) in bin {
                categories.append(cat)
            }
        }
                
        return (bins.count, categories)
    }
    
    static func getOpenDiagramsLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Open pie chart".localized()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
        
        return label
    }
    
    static func getDiagramsDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Visualise your activities with chart".localized()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        
        return label
    }
    
    static func size(categoryIsHidden: Bool, data: Int) -> CGSize {
        var cellHeight: CGFloat = 0
        
        let imagePadding: CGFloat = 16
        let imageWidth: CGFloat = 48
        let defaultHeight: CGFloat = 76
        let openDiagramsLabel = getOpenDiagramsLabel()
        let diagramsDescriptionLabel = getDiagramsDescriptionLabel()
        
        let pieChartHeight: CGFloat = 250
        let categoryCVHeight: CGFloat = CGFloat((32 + 12) * data)
        let periodLabelHeight: CGFloat = 24
        
        let textWidth = UIScreen.main.bounds.width - (2 * 16) - (2 * 16) - imagePadding - imageWidth
        let openDiagramsHeight: CGFloat = openDiagramsLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        let diagramsDescriptionHeight: CGFloat = diagramsDescriptionLabel.sizeThatFits(.init(width: textWidth, height: 0)).height
        
        let labelsHeight = openDiagramsHeight + diagramsDescriptionHeight + (2 * 16) + 8
        let diagramsViewHeight = labelsHeight > defaultHeight ? labelsHeight : defaultHeight
            
        cellHeight = categoryIsHidden ? diagramsViewHeight : pieChartHeight + 16 + categoryCVHeight + periodLabelHeight + 16 + 12
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: cellHeight
        )
    }
    
}
