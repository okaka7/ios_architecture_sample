//
//  UnsplashUser.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/05.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashUserTarget: UnsplashAPITargetType {
    typealias Response = UnsplashUserEntity
    
    var path: String {
       return "/users/\(userName)"
    }
    var method: Moya.Method {
        return .get
    }
    let userName: String
    var task: Task {
        return .requestPlain
    }
    
    init(userName: String) {
        self.userName = userName
    }
}

extension UnsplashUserTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
