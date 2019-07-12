//
//  OauthRepository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxMoya


extension Repository {
    struct DribbbleOauth {
        static let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
        
        static private func request<R>(_ request: R) -> Single<R.Response> where R:DribbbleOauthTargetType {
            let target = MultiTarget(request)
            return provider.rx.request(target).map(R.Response.self)
        }
        
        static func authenticateRequest() -> Single<Authentication.Response> {
            return request(Authentication())
        }
        
    }
}
