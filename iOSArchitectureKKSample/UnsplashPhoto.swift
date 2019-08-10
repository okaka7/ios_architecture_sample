//
//  UnsplashPhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/06.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashPhoto: UnsplashAPITargetType {
    
    typealias Response = UnsplashPhotoEntity
    
    var path: String {
        return "/photos/\(id)"
    }
    let method: Moya.Method = .get
    let id: String
    var task: Task {
        return .requestPlain
    }
    
    init(id: String) {
        self.id = id
    }
}

extension UnsplashPhoto: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
