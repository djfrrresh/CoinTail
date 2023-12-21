//
//  KeychainManager.swift
//  CoinTail
//
//  Created by Eugene on 27.11.23.
//

import Foundation
import Security


final class KeychainManager {
    
    static let shared = KeychainManager()
    
    private let apiKey = "17d2f298f8f15469bd89f9bb"
    private let service = "CoinTail"

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
            print("API Key did not found.")
        } else {
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
