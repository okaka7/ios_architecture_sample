//
//  UnsplashAccount.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/05.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashAccountTarget: UnsplashAPITargetType {
    typealias Account = UnsplashAccountEntity
    typealias Response = Account
    
    let path: String = "/me"
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        return .requestPlain
    }
    
}

extension UnsplashAccountTarget: UnsplashAccessTokenAuthorizable {}
