//
//  OauthTokenManageGateway.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct OauthTokenManageGateWay: APITokenRepository {
    
    let keychainStore: KeychainStorable
    
    init(keychainStorable: KeychainStorable) {
        self.keychainStore = keychainStorable
    }
    
    func saveToken(token: String) {
        self.keychainStore.save(key: R.string.localizable.unsplashToken(), value: token)
    }
    
    func fetchToken() -> String? {
        return self.keychainStore.load(key: R.string.localizable.unsplashToken())
    }
}
