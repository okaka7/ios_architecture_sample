//
//  UnsplashLikePhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/06.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashLikePhotoTarget: UnsplashAPITargetType {
    typealias Response = UnsplashPhotoEntity
    
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

extension UnsplashLikePhotoTarget: UnsplashAccessTokenAuthorizable {}
