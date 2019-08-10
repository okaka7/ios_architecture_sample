//
//  UnsplashCollectionRelatedCollections.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashCollectionRelatedCollectionsTarget: UnsplashAPITargetType {
    
    typealias Response = [UnsplashCollectionEntity]
    
    var path: String {
        return "/collections/\(id)/related"
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

extension UnsplashCollectionRelatedCollectionsTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
