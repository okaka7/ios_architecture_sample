//
//  LightAccessTokenPlugin.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/03.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

public protocol UnsplashAccessTokenAuthorizable { }

public struct LightAccessTokenPlugin: PluginType {
    let repository: APITokenRepository
    
    init(repository: APITokenRepository = OauthTokenManageGateWay()) {
        self.repository = repository
    }
    
    /**
     Prepare a request by adding an authorization header if necessary.
     
     - parameters:
     - request: The request to modify.
     - target: The target of the request.
     - returns: The modified `URLRequest`.
     */
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    
        guard let _ = target as? UnsplashAccessTokenAuthorizable else { return request }
        
        var request = request
        
        if let token = repository.fetchToken()?.rawValue {
            let authValue = "Bearer" + " " + token
            request.addValue(authValue, forHTTPHeaderField: "Authorization")
        } else {
            let authValue = "Client-ID" + " " + R.string.localizable.unsplashAPIClientID()
            request.addValue(authValue, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}

