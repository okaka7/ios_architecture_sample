//
//  UnsplashOauthToken.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct OauthTokenRequestGateway: UnsplashTokenRequestReposiotry {
    static func getCode(from components: URLComponents) -> String? {
        return components.queryItems?.getFirstQueryValue("code") as? String
    }
    
    let code: String
    
    let tokenRepository: APITokenRepository
    
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
    
    init(tokenRepository: APITokenRepository) {
        self.tokenRepository = tokenRepository
    }
    
    func saveToken(_ token: String) {
        tokenRepository.saveUnsplashToken(token)
    }
}
