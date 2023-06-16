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
    
    var categoriesArrCellData: [Category] = [Category]() {
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
    
    weak var categoryDelegate: CategoryDelegate?
    
    let categoriesCV: UICollectionView = {
        let categoryLayout: UICollectionViewFlowLayout = {
            var layout = UICollectionViewFlowLayout()
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
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        cv.isHidden = true
        
        return cv
    }()
        
    // Линейная диаграмма
    var progressView: MultiProgressView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        pieChart.delegate = self
        categoriesCV.delegate = self
        
        categoriesCV.dataSource = self
        
        contentView.addSubview(progressView)
        contentView.addSubview(pieChart)
        contentView.addSubview(categoriesCV)
        
        chartsGestureRecognizer() // Свойства кнопки для диаграмм
        configureChart() // Настройки для круговой диаграммы
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        progressView.easy.layout([
            Left(),
            Right(),
            Top(),
            Height(36)
        ])
        
        pieChart.easy.layout([
            Top(),
            Height(250),
            Width(250),
            CenterX()
        ])
        
        categoriesCV.easy.layout([
            Left(),
            Right(),
            Top(16).to(pieChart, .bottom),
            Bottom()
        ])
    }
    
    func chartsUpdate(_ segment: RecordType) {
        // Добавление записей в диаграммы
        setEntries(segment)
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
    }
    
    
    
    static func packBins(data: [Category]) -> (Int, [Category]) {
        var bins = [[(CGFloat, Category)]]()
        var categoriesWidth = [(CGFloat, Category)]()
        
        for category in data {
            categoriesWidth.append((CategoryCVCell.size(data: category.name).width, category))
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
        var categories = [Category]()
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
        var categoryCVHeight: CGFloat = CGFloat((32 + 12) * data)
            
        height = categoryIsHidden ? progressViewHeight : pieChartHeight + 16 + categoryCVHeight
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: height
        )
    }
}
