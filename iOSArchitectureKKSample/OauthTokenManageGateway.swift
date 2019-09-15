//
//  OauthTokenManageGateway.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import DataCache

struct OauthTokenManageGateWay: APITokenRepository {
   
    let keychainStore: Cache
    
    init(keychainStorable: Cache = KeychainCache.init(serviceName: Bundle.main.bundleIdentifier!)) {
        self.keychainStore = keychainStorable
    }
    
    func saveToken(token: UnsplashTokenEntity) {
        do {
            try self.keychainStore.save(.token, value: token)
        } catch {
            return
        }
    }
    
    func fetchToken() -> UnsplashTokenEntity? {
        let element: UnsplashTokenEntity?
        do {
            element = try self.keychainStore.fetch(.token)
            return element
        } catch {
            return nil
        }
    }
}
