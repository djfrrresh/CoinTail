//
//  PieChartVC.swift
//  CoinTail
//
//  Created by Eugene on 22.12.22.
//

import UIKit
import EasyPeasy
import Charts


class PieChartViewController: UIViewController, HomeVCSendData {
    
    var switchNum: Int
    
    var switchValue: String = "Income"
    
    // Круговая диаграмма, показывающая наглядно сумму операций
    var pieChart = PieChartView()
    // Массив записей в диаграмме
    var entries: [ChartDataEntry] = []
        
    var currentSegmentType: RecordType {
        return RecordType(rawValue: switchValue)!
    }
    
    var operationID: Int?
    let homeViewController: HomeViewController
    public required init(homeViewController: HomeViewController, operationID: Int? = nil, segmentIndex: Int) {
        self.homeViewController = homeViewController
        self.operationID = operationID
        self.switchNum = segmentIndex
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                
        self.view.backgroundColor = .white.withAlphaComponent(1)
        self.navigationController?.navigationBar.tintColor = .black        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("switchValue PieChart: \(String(describing: self.switchValue))")

        self.setChartView() // Настройки для диаграммы
        self.setChart() // Вывод данных на диаграмму
    }
    
}
