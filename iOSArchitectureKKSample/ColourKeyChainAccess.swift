//
//  ColourKeyChainAccess.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import KeychainAccess

struct ColourKeychainAccess {
    private static let keychain = Keychain(service: R.string.localizable.appHost())
    
    static var dribbbleToken: String? {
        return keychain[R.string.localizable.dribbbleToken()]
    }
    
    static func saveDribbbleToken(_ token: String) {
        keychain[R.string.localizable.dribbbleToken()] = token
    }
    
    
}
