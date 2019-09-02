//
//  UnsplashCollectionRelatedCollections.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashRelatedCollectionsTarget: UnsplashAPITargetType {
    
    typealias Response = [UnsplashCollectionValueObject]
    
    var path: String {
        return "/collections/\(id)/related"
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

extension UnsplashRelatedCollectionsTarget: UnsplashAccessTokenAuthorizable {}
