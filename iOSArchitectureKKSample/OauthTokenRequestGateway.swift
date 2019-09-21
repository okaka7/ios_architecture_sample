//
//  UnsplashOauthToken.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol CodeGettable {
    func getCode(from components: URLComponents) -> String?
}

extension CodeGettable {
    func getCode(from components: URLComponents) -> String? {
        return components.queryItems?.getQueryValue("code") as? String
    }
}

protocol TokenRequestable: class {
    func tokenRequest(with urlComponents: URLComponents,
                      completion:( (UnsplashTokenEntity) -> Void)?)
}

protocol TokenRequestTransmitter: class, CodeGettable {
    var useCase: TokenRequestUseCaseInputPort { get set }
    func tokenRequest(with urlComponents: URLComponents)
}

extension TokenRequestTransmitter {
    func tokenRequest(with urlComponents: URLComponents) {
        guard let code = self.getCode(from: urlComponents) else {
            return
        }
        useCase.requestToken(code: code)
    }
}

struct OauthTokenRequestGateway: TokenRequestReposiotry {
    
    private let tokenRequestClient: TokenRequestProtocol
    
    func requestToken(code: String) {
        tokenRequestClient.request(code: code,
                                   onSuccess: {tokenObject in
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
    
    init(tokenRequestClient: TokenRequestProtocol) {
        self.tokenRequestClient = tokenRequestClient
    }
}
