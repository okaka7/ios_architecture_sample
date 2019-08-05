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
        
        
        static let provider: MoyaProvider<MultiTarget> =  {
            
            //  Note: this plugin is for fetching Pagination links in photo items response header.
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
            let provider = MoyaProvider<MultiTarget>(plugins:
            [NetworkLoggerPlugin(verbose: true),
             fetchPaginationLinksPlugin
              ])
            return provider
        }()
        
        static private func request<R>(_ request: R) -> Single<R.Response> where R: UnsplashOauthTargetType {
            let target = MultiTarget(request)
            return provider.rx.request(target).map(R.Response.self)
        }
        
        
        
        static func tokenRequest(code: String) -> Single<UnsplashToken.Response> {
            return request(UnsplashToken(code: code))
        }
        
    }
}
