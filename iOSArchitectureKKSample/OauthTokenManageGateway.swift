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
        do {
            try self.keychainStore.save(.token, value: token)
        } catch {
            return
        }
        
    }
    
    func fetchToken() -> UnsplashTokenValueObject? {
        let element: UnsplashTokenValueObject?
        do {
            element = try self.keychainStore.fetch(.token)
            return element
        } catch {
            return nil
        }
    }
}
