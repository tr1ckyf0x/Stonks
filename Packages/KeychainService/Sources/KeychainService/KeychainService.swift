//
//  KeychainService.swift
//  
//
//  Created by Vladislav Lisianskii on 24.05.2022.
//

import Foundation

public protocol KeychainServiceProtocol {
    func saveValue(_ data: Data, for item: KeychainItem) throws
    func updateValue(_ data: Data, for item: KeychainItem) throws
    func readValue(for item: KeychainItem) throws -> Data
    func removeValue(for item: KeychainItem) throws
}

public final class KeychainService {
    public init() { }
}

extension KeychainService: KeychainServiceProtocol {
    public func saveValue(_ data: Data, for item: KeychainItem) throws {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: item.rawValue as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: data as AnyObject,
            kSecAttrAccessGroup as String: Constants.accessGroup as AnyObject,
            kSecUseDataProtectionKeychain as String: kCFBooleanTrue
        ]

        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )

        switch status {
        case errSecDuplicateItem:
            try updateValue(data, for: item)

        case errSecSuccess:
            return

        default:
            throw KeychainServiceError.unexpectedStatus(status)
        }
    }

    public func updateValue(_ data: Data, for item: KeychainItem) throws {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: item.rawValue as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccessGroup as String: Constants.accessGroup as AnyObject,
            kSecUseDataProtectionKeychain as String: kCFBooleanTrue
        ]

        let attributes: [String: AnyObject] = [
            kSecValueData as String: data as AnyObject
        ]

        let status = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )

        switch status {
        case errSecItemNotFound:
            throw KeychainServiceError.itemNotFound

        case errSecSuccess:
            return

        default:
            throw KeychainServiceError.unexpectedStatus(status)
        }
    }

    public func readValue(for item: KeychainItem) throws -> Data {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: item.rawValue as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue,
            kSecAttrAccessGroup as String: Constants.accessGroup as AnyObject,
            kSecUseDataProtectionKeychain as String: kCFBooleanTrue
        ]

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )

        switch status {
        case errSecItemNotFound:
            throw KeychainServiceError.itemNotFound

        case errSecSuccess:
            guard let password = itemCopy as? Data else {
                throw KeychainServiceError.invalidItemFormat
            }

            return password

        default:
            throw KeychainServiceError.unexpectedStatus(status)
        }
    }

    public func removeValue(for item: KeychainItem) throws {
        let query: [String: AnyObject] = [
            kSecAttrAccount as String: item.rawValue as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccessGroup as String: Constants.accessGroup as AnyObject,
            kSecUseDataProtectionKeychain as String: kCFBooleanTrue
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess else {
            throw KeychainServiceError.unexpectedStatus(status)
        }
    }
}

extension KeychainService {
    public enum KeychainServiceError: Error {
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }
}

// MARK: - Constants
extension KeychainService {
    private enum Constants {
        static let accessGroup = "SGM5527A99.com.tr1ckyf0x.stonksShared"
    }
}
