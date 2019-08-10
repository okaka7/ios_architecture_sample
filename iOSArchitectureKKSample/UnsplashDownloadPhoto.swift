//
//  UnsplashDownloadPhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashDownloadPhoto: UnsplashAPITargetType {
    
    typealias Response = String
    
    var path: String {
        return "/photos/\(id)/download"
    }
    var method: Moya.Method {
        return .get
    }
    let id: String
    var task: Task {
        return .requestPlain
    }
    
    init(id: String, like: Bool) {
        self.id = id
    }
}

extension UnsplashDownloadPhoto: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}