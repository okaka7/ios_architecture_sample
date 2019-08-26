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

protocol TokenRequestEmitter: class {
    var presenter: TokenRequestEmitAcceptable { get set }
    func tokenRequest(with urlComponents: URLComponents,
                      completion:((UnsplashTokenValueObject) -> Void)?)
}

protocol TokenRequestEmitAcceptable: class, CodeGettable {
    var tokenRequestUseCase: TokenRequestUseCaseInputPort { get set }
    func tokenRequest(with urlComponents: URLComponents)
}

extension TokenRequestEmitAcceptable {
    func tokenRequest(with urlComponents: URLComponents) {
        guard let code = self.getCode(from: urlComponents) else { return }
        tokenRequestUseCase.requestToken(code: code)
    }
}

struct OauthTokenRequestGateway: TokenRequestReposiotry {
    
    private let tokenRequestClient: TokenRequestClient
    
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
    
    init(tokenRequestClient: TokenRequestClient) {
        self.tokenRequestClient = tokenRequestClient
    }
}
