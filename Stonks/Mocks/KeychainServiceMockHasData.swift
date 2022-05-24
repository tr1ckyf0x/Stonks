//
//  KeychainServiceMockHasData.swift
//  Stonks
//
//  Created by Vladislav Lisianskii on 24.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import Foundation
import KeychainService

#if DEBUG
final class KeychainServiceMockHasData: KeychainServiceProtocol {
    func saveValue(_ data: Data, for item: KeychainItem) throws {
    }

    func updateValue(_ data: Data, for item: KeychainItem) throws {
    }

    func readValue(for item: KeychainItem) throws -> Data {
        return "01234567-89ab-cdef-0123-456789abcdef".data(using: .utf8)!
    }

    func removeValue(for item: KeychainItem) throws {
    }
}
#endif
