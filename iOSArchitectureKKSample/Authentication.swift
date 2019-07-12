//
//  DribbbleAuthentication.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct Authentication: DribbbleOauthTargetType {
    
    typealias OauthCode = String
    typealias Response = OauthCode
    
    private struct Parameter: Encodable {
        let clientID: String
        let scope: String
        let state: String
        
        enum CodingKeys: String, CodingKey {
            case clientID = "client_id"
            case scope
            case state
        }
        
        init(clientID: String = R.string.localizable.dribbbleAPIClientID(),
             scope: String = "public",
             state: String = UUID().uuidString) {
            self.clientID = clientID
            self.scope = scope
            self.state = state
        }
    }
    
    let path: String = "/authorize"
    let method: Moya.Method = .get
    
    var task: Task {
        let stateString = UUID().uuidString
        return .requestParameters(parameters: ["client_id": R.string.localizable.dribbbleAPIClientID(),
                                               "scope": "public",
                                               "state": stateString],
                                  encoding: URLEncoding.queryString)
    }
}

