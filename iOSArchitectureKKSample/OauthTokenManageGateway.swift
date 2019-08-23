//
//  OauthTokenManageGateway.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct OauthTokenManageGateWay: APITokenRepository {
    let keychainStore: Cacheable
    init(keychainStorable: Cacheable = KeyChainCache.shared) {
        self.keychainStore = keychainStorable
    }
    
    func saveToken(token: String) {
        self.keychainStore.save(<#T##key: CacheKey<CacheSettable & LocalCacheGettable, Cacheable>##CacheKey<CacheSettable & LocalCacheGettable, Cacheable>#>, value: <#T##CacheSettable & LocalCacheGettable#>)
    }
    
    func fetchToken() -> String? {
        return self.keychainStore.load(key: R.string.localizable.unsplashToken())
    }
}
