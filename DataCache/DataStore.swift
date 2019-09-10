//
//  LocalCacheable.swift
//  LocalCacheable
//
//  Created by Kota Kawanishi on 2019/08/21.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

public protocol Cacheable: class {
    func save<T: CacheValue>(_ key: CacheKey<T>, value: T) throws
    func fetch<T: CacheValue>(_ key: CacheKey<T>) throws -> T?
    func delete<T: CacheValue>(_ key: CacheKey<T>) throws
}

public protocol DataStorable: class {
    func save(_ key: String, value: Data)
    func fetch(_ key: String) -> Data?
    func delete(_ key: String)
}

extension Cacheable {
    
    public func save<T: CacheValue>(_ key: CacheKey<T>, value: T) throws {
        try T.set(key: key.rawValue, value: value, cache: self)
    }
    
    public func fetch<T: CacheValue>(_ key: CacheKey<T>) throws -> T? {
        return try T.get(key: key.rawValue, cache: self) ?? key.defaultValue
    }
    
    public func delete<T: CacheValue>(_ key: CacheKey<T>) throws {
        try T.set(key: key.rawValue, value: nil, cache: self)
    }
    // Note: You need to override this method
    internal var store: DataStorable { fatalError("abstract class instance") }
    
    internal func save(_ key: String, value: Data) {
        store.save(key, value: value)
    }
    
    internal func fetch(_ key: String) -> Data? {
        return store.fetch(key)
    }
    
    internal func delete(_ key: String) {
        store.delete(key)
    }
}


public class Cache: Cacheable {
    public init() {
        
    }
}

// MARK: LocalCacheValue
public protocol CacheSettable {
    static func set<Cache: Cacheable>(key: String, value: Self?, cache: Cache) throws
    static func set<Cache: Cacheable>(key: String, array: [Self], cache: Cache) throws
}

public protocol CacheGettable {
    static func get<Cache: Cacheable>(key: String, cache: Cache) throws -> Self?
    static func getArray<Cache: Cacheable>(key: String, cache: Cache) throws -> [Self]?
}

public typealias CacheValue = CacheGettable & CacheSettable

extension CacheSettable where Self: Encodable {
    public static func set<Cache: Cacheable>(key: String, value: Self?, cache: Cache) throws {
        guard let value = value else {
            cache.store.delete(key)
            return
        }
        guard let data = try encode(value) else {
            return
        }
        
        cache.store.save(key, value: data)
    }
    public static func set<Cache: Cacheable>(key: String, array: [Self], cache: Cache) throws {
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

extension CacheGettable where Self: Decodable {
    public static func get<Cache: Cacheable>(key: String, cache: Cache) throws -> Self? {
        guard let data = cache.store.fetch(key) else {
            return nil
        }
        return try decode(Self.self, from: data)
    }
    
    public static func getArray<Cache: Cacheable>(key: String, cache: Cache) throws -> [Self]? {
        guard let data = cache.store.fetch(key) else {
            return nil
        }
        return try decode([Self].self, from: data)
    }
    
    private static func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T? {
        return try JSONDecoder().decode(type, from: data)
    }
}

extension Array: CacheValue where Element: CacheValue {
    public static func get<Cache: Cacheable>(key: String, cache: Cache) throws -> Array<Element>? {
        return try Element.getArray(key: key, cache: cache)
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
