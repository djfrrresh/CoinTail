//
//  Int.swift
//  CoinTail
//
//  Created by Eugene on 19.06.23.
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

import Foundation


extension Int {
    
    // Функция выполняет нормализацию двух целых чисел с заданной базой.
    // Нормализация гарантирует, что значение `lo` остается в диапазоне [0, base-1], одновременно корректируя значение `hi`. Если `lo` отрицательно, оно переносится в положительный диапазон [0, base-1] путем вычитания кратных `base` из `hi`
    // Если `lo` превышает или равно `base`, оно сдвигается обратно в диапазон [0, base-1] путем добавления кратных `base` к `hi`.
    
    //  - hi: Высокая часть значения.
    //  - lo: Низкая часть значения.
    //  - base: Основание для нормализации.
    static func norm(hi: Int, lo: Int, base: Int) -> (nhi: Int, nlo: Int) {
        var hi = hi
        var lo = lo
        
        if lo < 0 {
            let n = (-lo - 1) / base + 1
            hi -= n
            lo += n * base
        }
        if lo >= base {
            let n = lo / base
            hi += n
            lo -= n * base
        }
        
        // Возвращает: Кортеж `(nhi, nlo)` с нормализованными значениями `hi` и `lo`.
        return (hi, lo)
    }
    
}
