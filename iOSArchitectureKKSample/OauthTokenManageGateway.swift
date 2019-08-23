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
    
    func saveToken(token: UnsplashTokenValueObject) {
        self.keychainStore.save(.token, value: token)
    }
    
    func fetchToken() -> UnsplashTokenValueObject? {
        return self.keychainStore.fetch(.token)
    }
}
