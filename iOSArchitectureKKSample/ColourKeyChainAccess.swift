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
    
   
    static var unsplashToken: String? {
        return keychain[R.string.localizable.unsplashToken()]
    }
    
    static func saveUnsplashToken(_ token: String) {
        keychain[R.string.localizable.unsplashToken()] = token
    }
}
