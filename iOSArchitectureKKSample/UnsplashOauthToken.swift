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
                             onSuccess successHandler: @escaping (UnsplashTokenTarget.Response) -> Void,
                             onError errorHandler: (Error) -> Void)
}

struct UnsplashOauthToken {
    
    static func getCode(from components: URLComponents) -> String? {
        return components.queryItems?.getFirstQueryValue("code") as? String
    }
    
    let code: String
    
    func requestToken(onSuccess successHandler: @escaping (UnsplashTokenTarget.Response) -> Void,
                      onError errorHandler: (Error) -> Void) {
        
        _ = Repository.UnsplashOauth
            .tokenRequest(code: self.code)
            .subscribe(
                onSuccess: { response in
                    successHandler(response)
                    #if DEBUG
                    log.debug("saveToken!!!!")
                    #endif
            },
                onError: {error in
                     #if DEBUG
                    log.error(error, context: "TokenRequestError")
                     #endif
            })
    }
    
    func saveToken(_ token: String) {
        ColourKeychainAccess.saveUnsplashToken(token)
    }
}
