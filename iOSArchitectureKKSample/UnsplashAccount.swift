//
//  UnsplashAccount.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/05.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashAccount: UnsplashAPITargetType {
    typealias Account = UnsplashUserEntity
    typealias Response = Account
    
    
    let path: String = "/me"
    let method: Moya.Method = .get
    var task: Task {
        return .requestPlain
    }
    
}

extension UnsplashAccount: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
