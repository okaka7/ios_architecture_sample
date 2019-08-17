//
//  UnsplashUsersLikes.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/06.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashUserLikesTarget: UnsplashAPITargetType {
    typealias Response = [UnsplashPhotoValueObject]
    
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
    
    var path: String {
        return "/users/\(userName)/likes"
    }
    let method: Moya.Method = .get
    let userName: String
    var task: Task {
        return .requestPlain
    }
    
    init(userName: String) {
        self.userName = userName
    }
}

extension UnsplashUserLikesTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
