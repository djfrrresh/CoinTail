//
//  OperationsChartView.swift
//  CoinTail
//
//  Created by Eugene on 13.12.22.
//

import UIKit
import Charts


extension PieChartViewController: ChartViewDelegate {
    
    func configureChart( _ pieChart: PieChartView) {
        pieChart.rotationEnabled = false
        pieChart.drawEntryLabelsEnabled = false
        pieChart.drawHoleEnabled = true
        pieChart.drawCenterTextEnabled = true
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
        pieChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.holeRadiusPercent = 0.3
        pieChart.transparentCircleRadiusPercent = 0.35
        pieChart.centerText = "Balance"
        
        let legend: Legend = pieChart.legend // Убрать список записей внизу диаграммы
        legend.enabled = false
    }
    
    // Отображение текста внутри записи
    func formatDataSet(_ dataSet: ChartDataSet) {
//        dataSet.drawValuesEnabled = false
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let labelText = entry.value(forKey: "label")! as! String
        let num = Int(entry.value(forKey: "value")! as! Double)
        pieChart.centerText = """
            \(labelText)
            \(num)
            """
    }
}
