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


extension UnsplashAPITargetType {
    
    public var baseURL: URL {
        return URL(string: R.string.localizable.unsplashAPIBaseURL())!
    }
    
    var headers: [String: String]? {
        return ["Accept-Version" : "v1"]
    }
    
    // TODO: あとでテストコードの際に具体的な返り値を設定
    var sampleData: Data { return Data() }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
