//
//  UnsplashCollectionPhotos.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashCollectionPhotosTarget: UnsplashAPITargetType {
    
    typealias Response = [UnsplashPhotoEntity]
    
    var path: String {
        return "/collections/\(id)/photos"
    }
    var method: Moya.Method {
        return .get
    }
    let id: String
    var task: Task {
        return .requestPlain
    }
    
    init(id: String) {
        self.id = id
    }
}

extension UnsplashCollectionPhotosTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
