//
//  UnsplashOauthAPI.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

protocol UnsplashOauthTargetType: TargetType {
    associatedtype Response: Codable
}



extension UnsplashOauthTargetType {
    
    public var baseURL: URL {
        return URL(string: R.string.localizable.unsplashOauthBaseURL())!
    }
    
    var headers: [String: String]? {
        return ["Authorization": R.string.localizable.unsplashAPIClientID()]
    }
    
    // TODO: あとでテストコードの際に具体的な返り値を設定
    var sampleData: Data { return Data() }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
