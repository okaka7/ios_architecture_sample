//
//  LocalCache.swift
//  DataCache
//
//  Created by Kota Kawanishi on 2019/09/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


class LocalDataStore: DataStorable {
    fileprivate static let shared: LocalDataStore = .init()
    private let store: UserDefaults = .standard
    
    func save(_ key: String, value: Data) {
        store.set(value, forKey: key)
    }
    
    func fetch(_ key: String) -> Data? {
        guard let data = store.data(forKey: key) else {
            return nil
        }
        return data
    }
    
    func delete(_ key: String) {
        store.set(nil, forKey: key)
    }
   
    private init() {}
}

final class LocalCache: Cache {
    let store: DataStorable = LocalDataStore.shared
}


