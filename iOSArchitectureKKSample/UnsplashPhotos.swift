//
//  UnsplashPhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

import Moya

struct UnsplashPhotos: UnsplashAPITargetType {
    
    typealias Response = String
    
    private struct Parameter: Encodable {
        let page: String
        let perPage: String
        let orderBy: OrderBy
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case orderBy = "order_by"
        }
        
        init(page: String = "1",
             perPage: String = "10",
             orderBy: OrderBy = .latest
            ) {
            
            self.page = page
            self.perPage = perPage
            self.orderBy = orderBy
        }
        
        var parameter: [String: Any] {
            return [
                "page": self.page,
                "per_page": self.perPage,
                "order_by": self.orderBy.rawValue
            ]
        }
    }
    
    let path: String = "/photos"
    let method: Moya.Method = .get
    let code: String
    var task: Task {
        return .requestPlain
    }
}
