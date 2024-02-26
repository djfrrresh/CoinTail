//
//  KeychainManager.swift
//  CoinTail
//
//  Created by Eugene on 27.11.23.
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
import Security
import KeychainSwift


final class KeychainManager {
    
    static let shared = KeychainManager()
    
    // API ключ для получения курса валют
    private let apiKey = "17d2f298f8f15469bd89f9bb"
    private let service = "CoinTail"
    
    private var UDIDfromKeyChain: String?

    // TODO: заменить на ОРИГИНАЛ
    func getUDID() -> String {
        if let udid = UDIDfromKeyChain {
            return udid
        }
        
        let keychain = KeychainSwift()
        let appIdentifierPrefix =
            Bundle.main.infoDictionary!["AppIdentifierPrefix"] as! String
        
        keychain.accessGroup = appIdentifierPrefix + "com.kunavinEugene.CoinTail.keychain"
        keychain.synchronizable = true
        
        if let UDID = keychain.get("UDID"), !UDID.isEmpty {
            UDIDfromKeyChain = UDID
            
            return UDID
        } else {
            let UDID = UUID().uuidString
            keychain.set(UDID, forKey: "UDID")
            UDIDfromKeyChain = UDID
            
            return UDID
        }
    }

    // Функция для извлечения API ключа из Keychain
    func getAPIKeyFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: apiKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess,
            let passwordData = result as? Data,
            let apiKey = String(data: passwordData, encoding: .utf8) {
            
            return apiKey
        } else if status == errSecItemNotFound {
            SentryManager.shared.capture(error: "API Key did not found", level: .error)
            print("API Key did not found")
        } else {
            SentryManager.shared.capture(error: "API Key extraction error: \(status)", level: .error)
            print("API Key extraction error: \(status)")
        }

        return nil
    }

    // Функция для сохранения API ключа в Keychain
    func saveAPIKeyToKeychain() {
        // Проверяем, существует ли уже ключ в Keychain
        if getAPIKeyFromKeychain() != nil {
            return
        } else {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: apiKey,
                kSecValueData as String: apiKey.data(using: .utf8)!
            ]
            
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
}
