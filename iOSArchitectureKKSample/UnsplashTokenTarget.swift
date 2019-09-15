//
//  UnsplashToken.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashTokenTarget: UnsplashOauthTargetType {
    typealias Response = UnsplashTokenValueObject
    
    private struct Parameter: Encodable {
        let clientID: String
        let clientSecret: String
        let redirectURI: String = {
            let scheme = R.string.localizable.appScheme()
            let host = R.string.localizable.appHost()
            let path = R.string.localizable.unsplashOauthCallBackPath()
            return "\(scheme)://\(host)\(path)"
        }()
        let code: String
        let grantType: String = "authorization_code"
        
        enum CodingKeys: String, CodingKey {
            case clientID = "client_id"
            case clientSecret = "client_secret"
            case redirectURI = "redirect_uri"
            case grantType = "grant_type"
            case code
        }
        
        init(clientID: String = R.string.localizable.unsplashAPIClientID(),
             clientSecret: String = R.string.localizable.unsplashAPIClientSecret(),
             code: String) {
            
            self.clientID = clientID
            self.clientSecret = clientSecret
            self.code = code
        }
    }
    
    let path: String = "/token"
    let method: Moya.Method = .post
    let code: String
    var task: Task {
        return .requestJSONEncodable(Parameter(code: self.code))
    }
    
    init(code: String) {
        self.code = code
    }
}
