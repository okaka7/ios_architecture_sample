//
//  SplashOauthRepository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxMoya

struct UnsplashOauthAPIProvider {
    static let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static private func request<R>(_ target: R) -> Single<R.Response> where R: UnsplashOauthTargetType {
        let target = MultiTarget(target)
        return provider.rx.request(target).map(R.Response.self)
    }
    
    static func tokenRequest(code: String) -> Single<UnsplashTokenTarget.Response> {
        let target: UnsplashTokenTarget = .init(code: code)
        return request(target)
    }
}
