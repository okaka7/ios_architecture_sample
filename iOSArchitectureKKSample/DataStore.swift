//
//  LocalCacheable.swift
//  LocalCacheable
//
//  Created by Kota Kawanishi on 2019/08/21.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import KeychainAccess

public protocol Cacheable {
    func save<T: CacheValue>(_ key: CacheKey<T>, value: T) throws
    func fetch<T: CacheValue>(_ key: CacheKey<T>) -> T?
    func delete<T: CacheValue>(_ key: CacheKey<T>) throws
}

public protocol DataStorable {
    
    func save(_ key: String, value: Data)
    func fetch(_ key: String) -> Data?
    func delete(_ key: String)
}

extension Cacheable {
    public func save<T: CacheValue>(_ key: CacheKey<T>, value: T) throws {
        try T.set(key: key.rawValue, value: value, cache: self)
    }
    
    public func fetch<T: CacheValue>(_ key: CacheKey<T>) -> T? {
        return T.get(key: key.rawValue, cache: self) ?? key.defaultValue
    }
    
    public func delete<T: CacheValue>(_ key: CacheKey<T>) throws {
        try T.set(key: key.rawValue, value: nil, cache: self)
    }
    // Note: You need to override this method
    fileprivate var store: DataStorable { fatalError("abstract class instance") }
    
    fileprivate func save(_ key: String, value: Data) {
        store.save(key, value: value)
    }
    
    fileprivate func fetch(_ key: String) -> Data? {
        return store.fetch(key)
    }
    
    fileprivate func delete(_ key: String) {
        store.delete(key)
    }
}

fileprivate class LocalDataStore: DataStorable {
    static let shared = LocalDataStore()
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

public final class LocalCache: Cacheable {
    static let shared = LocalCache()
    private init() {}
    
    fileprivate var store: LocalDataStore {
        return LocalDataStore.shared
    }
}

fileprivate class KeyChainDataStore: DataStorable {
    static let shared = KeyChainDataStore()
    
    private let store: Keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    func save(_ key: String, value: Data) {
        store[data: key] = value
    }
    
    public func fetch(_ key: String) -> Data? {
        return store[data: key]
    }
    
    public func delete(_ key: String) {
        store[data: key] = nil
    }
    
    private init() {}
}

public final class KeyChainCache: Cacheable {
    static let shared = KeyChainCache()
    private init() {}
    
    fileprivate var store: KeyChainDataStore {
        return KeyChainDataStore.shared
    }
}

// MARK: LocalCacheValue
public protocol CacheSettable {
    static func set<Cache: Cacheable>(key: String, value: Self?, cache: Cache) throws
    static func set<Cache: Cacheable>(key: String, array: [Self], cache: Cache) throws
}

public protocol LocalCacheGettable {
    static func get<Cache: Cacheable>(key: String, cache: Cache) -> Self?
    static func getArray<Cache: Cacheable>(key: String, cache: Cache) -> [Self]?
}

public typealias CacheValue = LocalCacheGettable & CacheSettable

extension CacheSettable where Self: Encodable {
    static func set<Cache: Cacheable>(key: String, value: Self?, cache: Cache) throws {
        guard let value = value else {
            cache.store.delete(key)
            return
        }
        guard let data = try encode(value) else {
            return
        }
        
        cache.store.save(key, value: data)
    }
    static func set<Cache: Cacheable>(key: String, array: [Self], cache: Cache) throws {
        guard array.isEmpty else {
            cache.store.delete(key)
            return
        }
        
        guard let data = try encode(array) else {
            return
        }
        
        cache.store.save(key, value: data)
    }
    
    private static func encode<T: Encodable>(_ value: T) throws -> Data? {
        return try JSONEncoder().encode(value)
    }
}

extension LocalCacheGettable where Self: Decodable {
    static func get<Cache: Cacheable>(key: String, cache: Cache) -> Self? {
        guard let data = cache.store.fetch(key) else {
            return nil
        }
        return decode(Self.self, from: data)
    }
    
    static func getArray<Cache: Cacheable>(key: String, cache: Cache) -> [Self]? {
        guard let data = cache.store.fetch(key) else {
            return nil
        }
        return decode([Self].self, from: data)
    }
    
    private static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }
}

extension Array: CacheValue where Element: CacheValue {
    public static func get<Cache: Cacheable>(key: String, cache: Cache) -> Array<Element>? {
        return Element.getArray(key: key, cache: cache)
    }
    
    public static func getArray<Cache : Cacheable>(key: String, cache: Cache) -> [Array<Element>]? {
        assertionFailure("two dimentional array not supported yet")
        return nil
    }
    
    public static func set<Cache: Cacheable>(key: String, value: [Element]?, cache: Cache) throws {
        guard let value = value else {
            cache.delete(key)
            return
        }
        try Element.set(key: key, array: value, cache: cache)
    }
    
    public static func set<Cache: Cacheable>(key: String, array: [Array<Element>], cache: Cache) {
        assertionFailure("two dimentional array not supported yet")
    }
    
}
