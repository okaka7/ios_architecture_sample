//
//  DribbbleOauthToken.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import KeychainAccess

struct DribbbleOauthToken {
    
    static let isReceivedStateCorrect: (URLComponents) -> Bool = { components in
        guard let receivedState: String = components.queryItems?.getFirstQueryValue("state") as? String,
            let sentState: DribbbleState = LocalCache.shared[.dribbbleState] else {
                return false
        }
        
        return sentState == receivedState
    }
    
    static func getCode(components: URLComponents) -> String? {
        return components.queryItems?.getFirstQueryValue("code") as? String
    }
    
    static func requestToken(code: String,
                             onSuccess successHandler: @escaping (TokenResponse) -> (),
                             onError errorHandler: (Error) -> ()) {
        
        
        Repository.DribbbleOauth
            .tokenRequest(code: code)
            .subscribe(
                onSuccess: { response in
                    successHandler(response)
                    log.debug("saveToken!!!!")
            },
                onError: {error in
                    log.error(error, context: "TokenRequestError")
            })
        
        
        LocalCache.shared[.dribbbleState] = nil
    }
    
    static func saveToken(_ token: String) {
        ColourKeychainAccess.saveDribbbleToken(token)
    }
}
