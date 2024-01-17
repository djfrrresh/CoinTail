//
//  PieChartConfigure.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
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
import Charts


extension HomeCategoryCell {

    // Настройки диаграммы
    func configureChart() {
        pieChart.rotationEnabled = false
        pieChart.drawEntryLabelsEnabled = false
        pieChart.drawHoleEnabled = true
        pieChart.drawCenterTextEnabled = false
        pieChart.holeColor = .clear
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
        pieChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.holeRadiusPercent = 0.7

        // Убрать список записей внизу диаграммы
        let legend: Legend = pieChart.legend
        legend.enabled = false
    }

    // Принимает все записи диаграммы и цвета категорий для отображения
    func updatePieChartData() {
        let dataSet = PieChartDataSet(entries: pieChartEntries, label: "")
        let data = PieChartData(dataSets: [dataSet])

        dataSet.valueTextColor = .clear
        dataSet.colors = pieChartColors
        
        pieChart.data = data
        pieChart.notifyDataSetChanged()
    }

}
