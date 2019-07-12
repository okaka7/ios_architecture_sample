//
//  DribbbleOauthAPI.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

protocol DribbbleOauthTargetType: TargetType {
    associatedtype Response: Codable
}



extension DribbbleOauthTargetType {
    
    public var baseURL: URL {
        return URL(string: R.string.localizable.dribbbleOauthBaseURL())!
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    // TODO: あとでテストコードの際に具体的な返り値を設定
    var sampleData: Data { return Data() }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
