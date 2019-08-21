//
//  LocalCache.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol LocalCacheSettable {
    static func set(key: String, value: Self?, cache: LocalCache)
    static func set(key: String, array: [Self], cache: LocalCache)
}

protocol LocalCacheGettable {
    static func get(key: String, cache: LocalCache) -> Self?
    static func getArray(key: String, cache: LocalCache) -> [Self]?
}

typealias LocalCacheValue = LocalCacheGettable & LocalCacheSettable

protocol LocalCacheable: class {
    func save<T: Encodable>(key: String, value: T)
    
    func fetch<T: Decodable>(key: String) -> T?
    
    func delete(key: String)
}

public protocol DataStorable {}
extension UserDefaults: DataStorable {}


final class LocalCache: LocalCacheable {
    static let shared = LocalCache()
    fileprivate let dataStore: DataStorable
    
    subscript<T: LocalCacheValue>(_ key: LocalCacheKey<T>) -> T? {
        set {
            T.set(key: key.keyValue, value: newValue, cache: self)
        }
        get {
            return T.get(key: key.keyValue, cache: self) ?? key.defaultValue
        }
    }
    private init(dataStore: DataStorable = UserDefaults.standard) {}
}

extension LocalCache {
    fileprivate func getDecodableObject<T: Decodable>(forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    fileprivate func setEncodableObject<T:Encodable>(forKey key: String, value: T) {
        guard let data = try? JSONEncoder().encode(value) else {
            return
        }
        
        userDefaults.set(data, forKey: key)
    }
    
    fileprivate func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}

extension LocalCacheSettable where Self: Encodable {
    static func set(key: String, value: Self?, cache: LocalCache) {
        guard let value = value else {
            cache.removeObject(forKey: key)
            return
        }
        cache.setEncodableObject(forKey: key, value: value)
    }
    
    static func set(key: String, array: [Self], cache: LocalCache) {
        guard array.isEmpty else {
            cache.removeObject(forKey: key)
            return
        }
        cache.setEncodableObject(forKey: key, value: array)
    }
}

extension LocalCacheGettable where Self: Decodable {
    static func get(key: String, cache: LocalCache) -> Self? {
        return cache.getDecodableObject(forKey: key) as Self?
    }
    
    static func getArray(key: String, cache: LocalCache) -> [Self]? {
        return cache.getDecodableObject(forKey: key) as [Self]?
    }
}


extension Array: LocalCacheValue where Element: LocalCacheValue {
    static func get(key: String, cache: LocalCache) -> [Element]? {
        return Element.getArray(key: key, cache: cache)
    }
    
    static func getArray(key: String, cache: LocalCache) -> [[Element]]? {
        assertionFailure("two dimentional array not supported yet")
        return nil
    }
    
    static func set(key: String, value: [Element]?, cache: LocalCache) {
        guard let value = value else {
            cache.removeObject(forKey: key)
            return
        }
        Element.set(key: key, array: value, cache: cache)
    }
    
    static func set(key: String, array: [[Element]], cache: LocalCache) {
        assertionFailure("two dimentional array not supported yet")
    }
}
