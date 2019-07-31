//
//  UnsplashOauthToken.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import KeychainAccess

protocol UnsplashTokenRequest {
    static func requestToken(code: String,
                             onSuccess successHandler: @escaping (TokenResponse) -> (),
                             onError errorHandler: (Error) -> ())
}

struct UnsplashOauthToken {
    static func requestToken(code: String,
                             onSuccess successHandler: @escaping (TokenResponse) -> (),
                             onError errorHandler: (Error) -> ()) {
        
        
        _ = Repository.DribbbleOauth
            .tokenRequest(code: code)
            .subscribe(
                onSuccess: { response in
                    successHandler(response)
                    log.debug("saveToken!!!!")
            },
                onError: {error in
                    log.error(error, context: "TokenRequestError")
            })
    }
    
    static func saveToken(_ token: String) {
        ColourKeychainAccess.saveUnsplashToken(token)
    }
}
