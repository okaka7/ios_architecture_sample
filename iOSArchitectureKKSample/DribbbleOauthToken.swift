//
//  DribbbleOauthToken.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import KeychainAccess

protocol DribbbleTokenRequest {
    static func requestToken(code: String,
                      onSuccess successHandler: @escaping (TokenResponse) -> (),
                      onError errorHandler: (Error) -> ())
}

struct DribbbleOauthToken: DribbbleTokenRequest {
    
    static func isReceivedStateCorrect(_ state: String) -> Bool {
        guard let sentState: DribbbleState = LocalCache.shared[.dribbbleState] else {
            return false
        }
        
        return sentState == state
    }
    
    static func isReceivedStateCorrect(from components:URLComponents) -> Bool {
        guard let state: String = components.queryItems?.getFirstQueryValue("state") as? String,
            let sentState: DribbbleState = LocalCache.shared[.dribbbleState] else {
                return false
        }
        
        return sentState == state
    }
    
    static func getState(from components: URLComponents) -> String? {
        return components.queryItems?.getFirstQueryValue("state") as? String
    }
    
    static func getCode(from components: URLComponents) -> String? {
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
