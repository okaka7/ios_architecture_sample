//
//  ColourAPI.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/04.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya

protocol DribbbleAPITargetType: TargetType {
    associatedtype Response: Codable
}


extension DribbbleAPITargetType {
    
    public var baseURL: URL {
        return URL(string: R.string.localizable.dribbbleAPIBaseURL())!
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.dribbble.v2.param+json"]
    }
    
    // TODO: あとでテストコードの際に具体的な返り値を設定
    var sampleData: Data { return Data() }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
