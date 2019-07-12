//
//  ReferrerURL.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct ReferrerURL: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "ReferrerURL"
    }
}
