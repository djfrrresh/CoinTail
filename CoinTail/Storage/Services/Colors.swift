//
//  Colors.swift
//  CoinTail
//
//  Created by Eugene on 13.06.23.
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


final class Colors {
    
    static let shared = Colors()
    
    // Income
    let salaryColor = UIColor(named: "salary")?.toHex()
    let debtRepaymentColor = UIColor(named: "debtRepayment")?.toHex()
    let sideJobColor = UIColor(named: "sideJob")?.toHex()
    let pleasantFindsColor = UIColor(named: "pleasantFinds")?.toHex()
    
    // Expense
    let transportColor = UIColor(named: "transport")?.toHex()
    let gloceryColor = UIColor(named: "glocery")?.toHex()
    let clothsColor = UIColor(named: "cloths")?.toHex()
    let gymColor = UIColor(named: "gym")?.toHex()
    let serviceColor = UIColor(named: "service")?.toHex()
    let subscriptionColor = UIColor(named: "subscription")?.toHex()
    let healthColor = UIColor(named: "health")?.toHex()
    let cafeColor = UIColor(named: "cafe")?.toHex()
    
}
