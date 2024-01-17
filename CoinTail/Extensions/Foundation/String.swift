//
//  String.swift
//  CoinTail
//
//  Created by Eugene on 24.08.23.
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


extension String {
    
    // Возвращает локализированную строку по ключу self (используем саму строку как ключ)
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func indexString(of substring: String) -> Int? {
        var index: Int?
        var indexOf = 0

        let substringArray = Array(substring)
        let selfArray = Array(self)

        for (i, character) in selfArray.enumerated() {
            guard character == substringArray[indexOf] else {
                index = nil
                indexOf = (character == substringArray[0]) ? 1 : 0
                continue
            }

            if index == nil {
                index = i
            }

            indexOf += 1

            guard indexOf == substringArray.count else {
                continue
            }

            return index
        }

        return index
    }
    
    // Проверяет текст на наличие эмодзи
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F,  // Emoticons
                 0x1F300...0x1F5FF,  // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF,  // Transport & Map Symbols
                 0x1F700...0x1F77F,  // Alchemical Symbols
                 0x1F780...0x1F7FF,  // Geometric Shapes Extended
                 0x1F800...0x1F8FF,  // Supplemental Arrows-C
                 0x1FA00...0x1FA6F,  // Chess Symbols
                 0x1FA70...0x1FAFF,  // Symbols and Pictographs Extended-A
                 0x2600...0x26FF,    // Misc Symbols
                 0x2700...0x27BF,    // Dingbats
                 0xFE00...0xFE0F,    // Variation Selectors
                 0x1F900...0x1F9FF:  // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
}
