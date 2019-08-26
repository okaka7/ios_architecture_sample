//
//  UnsplashAPI.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

protocol UnsplashAPITargetType: TargetType {
    associatedtype Response: Codable
}

enum OrderBy: String, Encodable {
    case latest
    case oldest
    case popular
}

extension UnsplashAPITargetType {
    
    public var baseURL: URL {
        return URL(string: R.string.localizable.unsplashAPIBaseURL())!
    }
    
    var headers: [String: String]? {
        return ["Accept-Version": "v1",
                "Authorization": "Bearer 6f3071aecb8ab60ee788b6202a67cc078d35bcd68e8a690bc200a1eaccf0f05b"]
    }
    
    // TODO: あとでテストコードの際に具体的な返り値を設定
    var sampleData: Data { return Data() }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
