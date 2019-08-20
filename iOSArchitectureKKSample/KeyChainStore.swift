//
//  ColourKeyChainAccess.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import KeychainAccess

public protocol KeychainStorable {
    func save(key: String, value: String)
    func load(key: String) -> String?
    func delete(key: String)
}

public final class KeychainStore: KeychainStorable {
    private let keychain: Keychain
    
    public init(_ keychainServiceName: String) {
        self.keychain = Keychain(service: keychainServiceName)
    }
    
    public func save(key: String, value: String) {
        keychain[key] = value
    }
    
    public func load(key: String) -> String? {
        return keychain[key]
    }
    
    public func delete(key: String) {
        return keychain[key] = nil
    }
//    
//    private static let keychain = Keychain(service: R.string.localizable.appHost())
//
//    static var unsplashToken: String? {
//        return keychain[R.string.localizable.unsplashToken()]
//    }
//
//    static func saveUnsplashToken(_ token: String) {
//        keychain[R.string.localizable.unsplashToken()] = token
//    }
}
