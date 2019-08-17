//
//  UserPortfolio.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashUserPortfolioTarget: UnsplashAPITargetType {
    typealias Response = UnsplashPortfolioValueObject
    
    var path: String {
        return "/users/\(userName)/portfolio"
    }
    let method: Moya.Method = .get
    let userName: String
    var task: Task {
        return .requestPlain
    }
    
    init(userName: String) {
        self.userName = userName
    }
}

extension UnsplashUserPortfolioTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
