//
//  TokenRequestUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol TokenRequestUseCaseInputPort {
    var tokenRequestRepository: TokenRequestReposiotry { get set }
    func requestToken(code: String)
}

extension TokenRequestUseCaseInputPort {
    func requestToken(code: String) {
        tokenRequestRepository.requestToken(code: code)
    }
}

protocol TokenRequestUseCaseOutputPort {
    
}

