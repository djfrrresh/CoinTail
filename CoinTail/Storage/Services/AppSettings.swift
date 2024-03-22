//
//  AppSettings.swift
//  CoinTail
//
//  Created by Eugene on 15.12.23.
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


class AppSettings {
    
    static let shared = AppSettings()
    
    private let realmService = RealmService.shared
    
    var premiumStatus: PremiumStatusClass {
        get {
            return realmService.read(PremiumStatusClass.self).first ?? createNoPremiumUser()
        }
        set {
            if let premium = realmService.read(PremiumStatusClass.self).first {
                realmService.realm?.beginWrite()
                premium.isPremiumActive = newValue.isPremiumActive
                premium.premiumActiveUntil = newValue.premiumActiveUntil
                
                do {
                    try realmService.realm?.commitWrite()
                } catch {
                    SentryManager.shared.capture(error: "Error updating premiumStatus: \(error.localizedDescription)", level: .error)
                    print("Error updating premiumStatus: \(error.localizedDescription)")
                }
            } else {
                let noPremiumUser = createNoPremiumUser()
                noPremiumUser.isPremiumActive = newValue.isPremiumActive
                noPremiumUser.premiumActiveUntil = newValue.premiumActiveUntil

                realmService.write(noPremiumUser, PremiumStatusClass.self)
            }
        }
    }
    
    // Если закончился срок действия подписки, делаем ее неактивной
    func setPremiumUnactive(completion: ((Bool, Int64?) -> Void)? = nil) {
        let isPremiumStillActive = premiumStatus.stillActive
        let activeUntil = premiumStatus.premiumActiveUntil
                
        if !isPremiumStillActive {
            let noPremiumUser = PremiumStatusClass()
            noPremiumUser.isPremiumActive = false
            noPremiumUser.premiumActiveUntil = nil
            
            completion?(false, activeUntil)
            
            // Обновляем статус после completion, чтобы сохранить дату
            premiumStatus = noPremiumUser
            
            return
        }
        
        completion?(true, nil)
    }
    
    private func createNoPremiumUser() -> PremiumStatusClass {
        let noPremiumUser = PremiumStatusClass()
        noPremiumUser.isPremiumActive = false
        
        return noPremiumUser
    }
    
}
