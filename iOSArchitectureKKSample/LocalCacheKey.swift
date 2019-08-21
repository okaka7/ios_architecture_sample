//
//  LocalCacheKey.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol LocalCacheKeys {
    associatedtype Value: LocalCacheValue
    var keyValue: String { get }
    var defaultValue: Value? { get }
}

struct LocalCacheKey<Value: LocalCacheValue>: LocalCacheKeys {
    let keyValue: String
    let defaultValue: Value?
    
    fileprivate init(_ rawValue: String, defaultValue: Value?) {
        self.keyValue = rawValue
        self.defaultValue = defaultValue
    }
}

extension LocalCacheKeys {
    
}

