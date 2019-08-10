//
//  UnsplashLikePhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/06.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashLikePhoto: UnsplashAPITargetType {
    
    typealias Response = String
    
    var path: String {
        return "/photos/\(id)/like"
    }
    var method: Moya.Method {
        return self.like ? .post : .delete
    }
    let id: String
    let like: Bool
    var task: Task {
        return .requestPlain
    }
    
    init(id: String, like: Bool) {
        self.id = id
        self.like = like
    }
}

extension UnsplashLikePhoto: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
