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
    
    var categoriesArrCellData: [HomeCVCategory] = [HomeCVCategory]()
    var progressValuesCellData: [UsagesModel] = []
    var pieChartEntriesCellData: [ChartDataEntry] = []
    
    let categoriesCV: UICollectionView = {
        let categoryLayout: UICollectionViewFlowLayout = {
            var layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 12
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            return layout
        }()

        let cv = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)
        cv.scrollIndicatorInsets = .zero
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
        progressChart.translatesAutoresizingMaskIntoConstraints = false
        progressChart.isHidden = false
        return progressChart
    }()
    
    // Круговая диаграмма
    let pieChart: PieChartView = {
        let pieChart = PieChartView()
        pieChart.translatesAutoresizingMaskIntoConstraints = false
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
            Width(250)
        ])
        
        categoriesCV.easy.layout([
            Left(),
            Right(),
            Top(16).to(pieChart, .bottom)
        ])
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
    
    static func size() -> CGSize {
        return .init(
            width: UIScreen.main.bounds.width - 16 * 2,
            height: 32
        )
    }
}
