//
//  UnsplashTokenValueObject.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/23.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct UnsplashTokenValueObject: Codable {
    let rawValue: String

    init (_ value: UnsplashTokenResposneValueObject) {
        self.rawValue = tokenValue.accessToken
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
