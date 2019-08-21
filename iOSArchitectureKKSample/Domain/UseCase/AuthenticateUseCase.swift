//
//  AuthenticateUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol AuthenticationUseCaseOutputPort {
    func openURL(url: URL)
}

protocol AuthenticationUseCaseInputPort {
    var authenticator: AuthorizableURL { get }
    var output: AuthenticationUseCaseOutputPort { get set }
    func openAuthenticationURL()
}

extension AuthenticationUseCaseInputPort {
    func openAuthenticationURL() {
        guard let url = authenticator.url else {
            return
        }
        
        output.openURL(url: url)
    }
}
