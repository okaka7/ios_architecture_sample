//
//  UnsplashPhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

import Moya

struct UnsplashPhotosTarget: UnsplashAPITargetType {
    typealias Response = [UnsplashPhotoEntity]
    
    private struct Parameter: Encodable {
        let page: String
        let perPage: String
        let orderBy: OrderBy
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case orderBy = "order_by"
        }
        
        init(page: String,
             perPage: String,
             orderBy: OrderBy) {
            
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
    let task: Task
    
    init(page: Int,
         perPage: Int,
         orderBy: OrderBy) {
        let parameter = Parameter(page: String(page),
                                  perPage: String(perPage),
                                  orderBy: orderBy)
        self.task = .requestParameters(parameters: parameter.parameter,
                                       encoding: URLEncoding.default)
    }
}

extension UnsplashPhotosTarget: UnsplashAccessTokenAuthorizable {}
