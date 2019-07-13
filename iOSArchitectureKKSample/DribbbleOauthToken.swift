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
    typealias Token = String
    
    let components: URLComponents
    private let isReceivedStateCorrect: (URLComponents) -> Bool = { components in
        guard let receivedState: String = components.queryItems?.getFirstQueryValue("state") as? String,
            let sentState: DribbbleState = LocalCache.shared[.dribbbleState] else {
                return false
        }
        
        return sentState == receivedState
    }
    
    init(components: URLComponents) {
        self.components = components
    }
    
    func requestToken(onSuccess successHandler: @escaping (TokenResponse) -> (),
                      onError errorHandler: (Error) -> ()) {
        if isReceivedStateCorrect(components) {
            guard let code = components.queryItems?.getFirstQueryValue("code") as? String else {
                return
            }
            
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
            
        }
        LocalCache.shared[.dribbbleState] = nil
    }
    
    func saveToken(_ token: String) {
        ColourKeychainAccess.saveDribbbleToken(token)
    }
}
