//
//  UnsplashManagePhotoInCollectionTarget.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

struct UnsplashEditPhotoInCollectionTarget: UnsplashAPITargetType {
    typealias Response = SearchPhotoReponseValueObject
    
    private struct Parameter: Encodable {
        let photoID: String
        
        
        enum CodingKeys: String, CodingKey {
            case photoID = "photo_id"
        }
        
        init(photoID: String) {
            self.photoID = photoID
        }
        
    }
    
    var path: String {
        let endPath = self.isAdding ? "/add" : "/remove"
        return "/collections/\(self.collectionID)/\(endPath)"
    }
    var method: Moya.Method {
        return self.isAdding ? .post : .delete
    }
    let isAdding: Bool
    let collectionID: String
    let photoID: String
    var task: Task {
        return .requestJSONEncodable(Parameter(photoID: self.photoID))
    }
    
    init(isAdding: Bool,
         collectionID: String,
         photoID: String) {
        self.isAdding = isAdding
        self.collectionID = collectionID
        self.photoID = photoID
    }
}

extension UnsplashEditPhotoInCollectionTarget: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        return .bearer
    }
}
