//
//  String.swift
//  CoinTail
//
//  Created by Eugene on 24.08.23.
//

import Foundation


extension String {
    
    // Возвращает локализированную строку по ключу self (используем саму строку как ключ)
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    //TODO: переделать функцию, сделать учитывание дополнительной подстроки, убрать кучу if
    func indexString(of substring: String) -> Int? {
        var index: Int?
        var indexOf: Int = 0
        let substring = substring.map { $0 }
        
        for (i, character) in self.enumerated() {
            if character == substring[indexOf] {
                if index == nil {
                    index = i
                }
                indexOf += 1
                
                if indexOf == substring.count - 1 {
                    return index
                }
            } else {
                index = nil
                indexOf = 0
            }
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
