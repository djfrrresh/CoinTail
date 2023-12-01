//
//  HomeCategoryCell.swift
//  CoinTail
//
//  Created by Eugene on 12.06.23.
//

import UIKit
import EasyPeasy
import Charts
import MultipleProgressBar


final class HomeCategoryCell: UICollectionViewCell, ChartViewDelegate {
    
    static let id = "HomeCategoryCell"
    
    var category: CategoryClass?
    
    var categoriesArrCellData = [CategoryClass]() {
        didSet {
            categoriesCV.reloadData()
        }
    }
    // Хранимые значения в линейной диаграмме
    var progressChartEntries: [UsagesModel] = []
    // Массив записей в круговой диаграмме
    var pieChartEntries: [ChartDataEntry] = []
    // Цвета для круговой диаграммы
    var pieChartColors: [UIColor] = []
    
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

        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.isHidden = true
        
        return cv
    }()
        
    // Линейная диаграмма
    let progressView: MultiProgressView = {
        let progressChart = MultiProgressView()
        progressChart.layer.cornerRadius = 8
        progressChart.layer.masksToBounds = true
        progressChart.isHidden = false
        
        return progressChart
    }()
    
    // Круговая диаграмма
    let pieChart: PieChartView = {
        let pieChart = PieChartView()
        pieChart.isHidden = true
        
        return pieChart
    }()
    
    let periodLabel = UILabel()
    let amountForPeriodLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        
        return label
    }()
    
    let arrowImageLeft: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.left"))
        imageView.tintColor = .gray
        imageView.isHidden = true
        
        return imageView
    }()
    
    let arrowImageRight: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .gray
        imageView.isHidden = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        pieChart.delegate = self
        categoriesCV.delegate = self
        
        categoriesCV.dataSource = self
        
        contentView.addSubview(periodLabel)
        contentView.addSubview(amountForPeriodLabel)
        contentView.addSubview(progressView)
        contentView.addSubview(pieChart)
        contentView.addSubview(arrowImageLeft)
        contentView.addSubview(arrowImageRight)
        contentView.addSubview(categoriesCV)
        
        chartsGestureRecognizer() // Свойства кнопки для диаграмм
        configureChart() // Настройки для круговой диаграммы
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        periodLabel.easy.layout([
            Top(),
            Left(),
            Height(32)
        ])
        
        amountForPeriodLabel.easy.layout([
            Top(),
            Left(8).to(periodLabel, .right),
            Right(),
            Height(32)
        ])
        
        progressView.easy.layout([
            Left(),
            Right(),
            Top(16).to(periodLabel, .bottom),
            Height(36)
        ])
        
        pieChart.easy.layout([
            Top(16).to(periodLabel, .bottom),
            Height(pieChart.isHidden ? 0 : 250),
            Width(pieChart.isHidden ? 0 : 250),
            CenterX()
        ])
        
        arrowImageLeft.easy.layout([
            CenterY().to(pieChart),
            Height(pieChart.isHidden ? 0 : 24),
            Width(pieChart.isHidden ? 0 : 14),
            Left()
        ])
        
        arrowImageRight.easy.layout([
            CenterY().to(pieChart),
            Height(pieChart.isHidden ? 0 : 24),
            Width(pieChart.isHidden ? 0 : 14),
            Right()
        ])
        
        categoriesCV.easy.layout([
            Left(),
            Right(),
            Top(16).to(pieChart, .bottom),
            Bottom()
        ])
    }
    
    func arrowIsHidden(left: Bool, right: Bool) {
        arrowImageLeft.isHidden = left
        arrowImageRight.isHidden = right
    }
    
    func chartsUpdate(_ segment: RecordType, records: [RecordClass]) {
        // Добавление записей в диаграммы
        setEntries(segment, records: records)
        // Добавление данных в диаграммы
        updatePieChartData()
        progressView.updateViews(usageModels: progressChartEntries)
    }
    
    // Привязка функций кнопки к диаграммам
    private func chartsGestureRecognizer() {
        let progressBarTap = UITapGestureRecognizer(target: self, action: #selector(pieChartAction))
        progressView.addGestureRecognizer(progressBarTap)
        progressView.isUserInteractionEnabled = true

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
        for (width, category) in categoriesWidth {
            var found = false
            
            for bin in bins.indices {
                let spacing: CGFloat = 12
                let currentRowWidth: CGFloat = bins[bin].map({ (w, _) in
                    w
                }).reduce(0, +)
                
                let spacingBetweenCurrentItems: CGFloat = CGFloat(bins[bin].count) * spacing
                if currentRowWidth + width + spacingBetweenCurrentItems <= screenWidth {
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
    
    static func size(categoryIsHidden: Bool, data: Int) -> CGSize {
        var height: CGFloat = 0
        let progressViewHeight: CGFloat = 36
        let pieChartHeight: CGFloat = 250
        let categoryCVHeight: CGFloat = CGFloat((32 + 12) * data)
        let periodLabelHeight: CGFloat = 32
            
        height = categoryIsHidden ? progressViewHeight + periodLabelHeight + 16 : pieChartHeight + 16 + categoryCVHeight + periodLabelHeight + 16
        
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: height
        )
    }
}
