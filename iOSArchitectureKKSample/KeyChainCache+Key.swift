//
//  KeyChainCache+Key.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import DataCache

extension CacheKeys {
    static var token: CacheKey<UnsplashTokenValueObject> {
        return CacheKey("token")
    }
}

extension UnsplashTokenValueObject: CacheValue {}
extension LogIn: CacheValue {}
