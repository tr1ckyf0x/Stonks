//
//  KeychainServiceMockNoData.swift
//  Stonks
//
//  Created by Vladislav Lisianskii on 24.05.2022.
//  Copyright © 2022 Vladislav Lisianskii. All rights reserved.
//

import Foundation
import KeychainService

#if DEBUG
final class KeychainServiceMockNoData: KeychainServiceProtocol {
    func saveValue(_ data: Data, for item: KeychainItem) throws {
    }

    func updateValue(_ data: Data, for item: KeychainItem) throws {
    }

    func readValue(for item: KeychainItem) throws -> Data {
        throw KeychainService.KeychainServiceError.itemNotFound
    }

    func removeValue(for item: KeychainItem) throws {
    }
}
#endif
