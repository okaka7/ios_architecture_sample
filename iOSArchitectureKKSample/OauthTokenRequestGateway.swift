//
//  UnsplashOauthToken.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Result

protocol CodeGettable {
    func getCode(from components: URLComponents) -> String?
}

extension CodeGettable {
    func getCode(from components: URLComponents) -> String? {
        return components.queryItems?.getFirstQueryValue("code") as? String
    }
}

protocol TokenRequestable: class {
    func tokenRequest(with urlComponents: URLComponents)
}

struct OauthTokenRequestGateway: TokenRequestReposiotry {
    
    let tokenRequestClient: TokenRequestClient
    
    func requestToken(code: String) {
        tokenRequestClient.request(code: code,
                                   onSuccess: { tokenObject in
                                        #if DEBUG
                                        log.debug("saveToken!!!!")
                                        #endif
                                    },
                                    onError: { error in
                                        #if DEBUG
                                        log.error(error, context: "TokenRequestError")
                                        #endif
                                    })
    }
    
    
    init(tokenRequestClient: TokenRequestClient) {
        self.tokenRequestClient = tokenRequestClient
    }
}
