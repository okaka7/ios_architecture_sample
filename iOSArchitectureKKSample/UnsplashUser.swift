//
//  UnsplashUser.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/05.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashUser: UnsplashAPITargetType {
    typealias Response = UnsplashUserEntity
    
    private struct Parameter: Encodable {
        let user: String
        
        enum CodingKeys: String, CodingKey {
            case user
        }
        
        init(user: String) {
            self.user = user
        }
    }
    
    let path: String = "/users"
    let method: Moya.Method = .post
    let user: String
    var task: Task {
        return .requestParameters(parameters: ["username": Parameter(user: user)],
                                  encoding: URLEncoding.default)
    }
    
    init(user: String) {
        self.user = user
    }
}
