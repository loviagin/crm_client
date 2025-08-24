//
//  KeychainHelper.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import Foundation
import Security

final class KeychainHelper {
    static let shared = KeychainHelper()
    private var service = "com.lovigin.CRM"

    private init() {}

    func save(_ data: Data, account: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecValueData as String   : data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    func read(account: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]

        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }

    func delete(account: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : account
        ]

        SecItemDelete(query as CFDictionary)
    }

    // Удобные методы для строк
    func save(_ string: String, account: String) {
        if let data = string.data(using: .utf8) {
            save(data, account: account)
        }
    }

    func readString(account: String) -> String? {
        guard let data = read(account: account) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
