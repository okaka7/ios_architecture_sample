//
//  KeychainCache.swift
//  DataCache
//
//  Created by Kota Kawanishi on 2019/09/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import KeychainAccess

class KeyChainDataStore: DataStorable {
    private let store: Keychain
    func save(_ key: String, value: Data) {
        store[data: key] = value
    }
    
    func fetch(_ key: String) -> Data? {
        return store[data: key]
    }
    
    func delete(_ key: String) {
        store[data: key] = nil
    }
    
    fileprivate init(serviceName: String) {
        self.store = Keychain.init(service: serviceName)
    }
}


final class KeychainCache: Cache {
    let store: DataStorable
    
    init(serviceName: String) {
        self.store = KeyChainDataStore.init(serviceName: serviceName)
    }
}
