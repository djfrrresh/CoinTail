//
//  HomeUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 18.05.23.
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


extension HomeVC: SelectedSegmentDate {
    
    func sendSegment(_ segment: RecordType, index: Int) {
        segmentIndex = index
        homeSegment = segment
        categorySort = nil
        currentStep = borderStep(
            for: Records.shared.records,
            isLeft: true
        )
        
        sortOperations() // Сортировка коллекции с операциями
    }
    
    // Передает выбранный период и обнуляет счетчик шагов для диаграммы
    func selectedPeriod(_ period: DatePeriods) {
        self.period = period
        currentStep = borderStep(for: Records.shared.records, isLeft: true)
        
        sortOperations()
    }
        
    func homeButtonTargets() {
        addOperationButton.addTarget(self, action: #selector(goToAddOperationVC), for: .touchUpInside)
        customNavBar.customButton.addTarget(self, action: #selector(goToAddOperationVC), for: .touchUpInside)
    }
        
}
