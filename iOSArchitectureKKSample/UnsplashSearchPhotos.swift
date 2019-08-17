//
//  UnsplashSearchPhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

enum PhotoOrientation: String {
    case portraint
    case landscape
    case squarish
}

struct UnsplashSearchPhotosTarget: UnsplashAPITargetType {
    typealias Response = SearchPhotoReponseValueObject
    
    private struct Parameter: Encodable {
        let query: String
        let page: String
        let perPage: String
        let orientation: PhotoOrientation
        
        enum CodingKeys: String, CodingKey {
            case query
            case page
            case perPage = "per_page"
        }
        
        init(query: String,
             page: String = "1",
             perPage: String = "10",
             orientation: PhotoOrientation = .portraint
            ) {
            self.query = query
            self.page = page
            self.perPage = perPage
            self.orientation = orientation
        }
        
        var parameter: [String: Any] {
            return [
                "query": self.query,
                "page": self.page,
                "per_page": self.perPage,
                "orientation": self.orientation
            ]
        }
    }
    
    var path: String {
        return "/search/photos"
    }
    let method: Moya.Method = .get
    let query: String
    var task: Task {
        return .requestParameters(parameters: Parameter(query: self.query).parameter, encoding: URLEncoding.default)
    }
    
    init(query: String) {
        self.query = query
    }
}

extension UnsplashSearchPhotosTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
