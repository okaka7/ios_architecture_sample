//
//  Token.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct Token: DribbbleOauthTargetType {
    
    typealias Response = TokenResponse
    
    private struct Parameter: Encodable {
        let clientID: String
        let clientSecret: String
        let code: String
        
        enum CodingKeys: String, CodingKey {
            case clientID = "client_id"
            case clientSecret = "client_secret"
            case code
        }
        
        init(clientID: String = R.string.localizable.dribbbleAPIClientID(),
             clientSecret: String = R.string.localizable.dribbbleAPIClientSecret(),
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
        return .requestJSONEncodable(Parameter(code: code))
    }
    
    init(code: String) {
        self.code = code
    }
}
