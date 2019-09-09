//
//  DataStoreKey.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/22.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

// MARK: CacheKey
public protocol CacheKeys {
    associatedtype Value: CacheValue
    var rawValue: String { get }
    var defaultValue: Value? { get }
}

public class CacheKey<Value: CacheValue>: CacheKeys {
    public let rawValue: String
    public let defaultValue: Value?
    
    fileprivate init(_ rawValue: String, defaultValue: Value?) {
        self.rawValue = rawValue
        self.defaultValue = defaultValue
    }
}

extension CacheKeys {
    static var token: CacheKey<UnsplashTokenValueObject> {
        return CacheKey("token", defaultValue: nil)
    }
    
    static var peopleCategory: CacheKey<UnsplashPhotoEntity> {
        return CacheKey("people", defaultValue: nil)
    }
    
    static var travelCategory: CacheKey<UnsplashPhotoEntity> {
        return CacheKey("travel", defaultValue: nil)
    }
    
    static var animalCategory: CacheKey<UnsplashPhotoEntity> {
        return CacheKey("animal", defaultValue: nil)
    }
    
    static var fashionCategory: CacheKey<UnsplashPhotoEntity> {
        return CacheKey("fashion", defaultValue: nil)
    }
    
    static var artCategory: CacheKey<UnsplashPhotoEntity> {
        return CacheKey("art", defaultValue: nil)
    }
    
    static var natureCategory: CacheKey<UnsplashPhotoEntity> {
        return CacheKey("nature", defaultValue: nil)
    }
    
    static var architectureCategory: CacheKey<UnsplashPhotoEntity> {
        return CacheKey("architecture", defaultValue: nil)
    }
    
    
}

extension UnsplashTokenValueObject: CacheValue {}
extension UnsplashPhotoEntity: CacheValue {}
