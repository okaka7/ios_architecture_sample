//
//  UnsplashAPIRepository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/05.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxMoya

extension Repository {
    struct UnsplashAPI {
        
        static let provider: MoyaProvider<MultiTarget> = {
            //  Note: this plugin is for fetching Pagination links in photo items response header.
            let loggerPlugin: NetworkLoggerPlugin = .init(verbose: true)
            let fetchPaginationLinksPlugin: NetworkActivityPlugin = .init(networkActivityClosure: {
                (change: NetworkActivityChangeType, target: TargetType) in
                guard let multiTarget = target as? MultiTarget else {
                    return
                }
                
                if  change == .ended,
                    let headers = target.headers,
                    let links = headers["Link"] {
                    
                }
            })
            
            let accessTokenPlugin: AccessTokenPlugin = .init(tokenClosure: { () -> String in
                if let token = ColourKeychainAccess.unsplashToken {
                    return token
                } else {
                    return R.string.localizable.unsplashAPIClientID()
                }
            })
            
            let provider = MoyaProvider<MultiTarget>(plugins:
            [loggerPlugin,
             fetchPaginationLinksPlugin,
             accessTokenPlugin
              ])
            return provider
        }()
        
        static private func request<R>(_ target: R) -> Single<R.Response> where R: UnsplashAPITargetType {
            let target = MultiTarget(target)
            return provider.rx.request(target).map(R.Response.self)
        }
        
        static func requestAccount() -> Single<UnsplashAccountTarget.Response> {
            let target: UnsplashAccountTarget = .init()
            return request(target)
        }
        
        static func requestUser(user: String) -> Single<UnsplashUserTarget.Response> {
            let target: UnsplashUserTarget = .init(userName: user)
            return request(target)
        }
        
    }
}
