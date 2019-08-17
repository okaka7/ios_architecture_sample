//
//  UnsplashOauthRepository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol AuthenticationRepository {
    func authenticate()
}

protocol UnsplashTokenRequestReposiotry {
    static func requestToken(code: String,
                             onSuccess successHandler: @escaping (UnsplashTokenTarget.Response) -> Void,
                             onError errorHandler: (Error) -> Void)
}
