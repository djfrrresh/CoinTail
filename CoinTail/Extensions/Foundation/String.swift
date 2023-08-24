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
    
}
