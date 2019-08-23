//
//  TokenRepository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol APITokenRepository {
    func saveToken(token: UnsplashTokenValueObject)
    func fetchToken() -> UnsplashTokenValueObject?
}
