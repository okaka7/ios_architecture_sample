//
//  UsersPortfolio.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/06.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashUserPhotosTarget: UnsplashAPITargetType {
    typealias Response = [UnsplashUserEntity]
    
    private struct Parameter: Encodable {
        let page: String
        let perPage: String 
        let orderBy: OrderBy
        let stats: Bool
        let resolution: String
        let quantity: String
        
        enum CodingKeys: String, CodingKey {
            case page, stats, resolution, quantity
            case perPage = "per_page"
            case orderBy = "order_by"
        }
        
        init(page: String = "1",
             perPage: String = "10",
             orderBy: OrderBy = .latest,
             stats: Bool = false,
             resolution: String = "days",
             quantity: String = "30"
             ) {
            
            self.page = page
            self.perPage = perPage
            self.orderBy = orderBy
            self.stats = stats
            self.resolution = resolution
            self.quantity = quantity
        }
        
        var parameter: [String: Any] {
            return [
                "page": self.page,
                "per_page": self.perPage,
                "order_by": self.orderBy.rawValue,
                "stats": self.stats,
                "resolution": self.resolution,
                "quantity": self.quantity
            ]
        }
    }
    
    var path: String {
        return "/users/\(userName)/photos"
    }
    var method: Moya.Method {
        return .get
    }
    let userName: String
    var task: Task {
        return .requestParameters(parameters: Parameter().parameter,
                                  encoding: URLEncoding.default)
    }
    
    init(userName: String) {
        self.userName = userName
    }
}

extension UnsplashUserPhotosTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
