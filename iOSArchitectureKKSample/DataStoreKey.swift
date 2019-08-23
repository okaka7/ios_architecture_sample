//
//  DataStoreKey.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/22.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

// MARK: CacheKey
public protocol LocalCacheKeys {
    associatedtype Value: CacheValue
    var rawValue: String { get }
    var defaultValue: Value? { get }
}


public class CacheKey<Value: CacheValue>: LocalCacheKeys {
    public let rawValue: String
    public let defaultValue: Value?
    
    fileprivate init(_ rawValue: String, defaultValue: Value?) {
        self.rawValue = rawValue
        self.defaultValue = defaultValue
    }
}

extension Account: LocalCacheValue {}
