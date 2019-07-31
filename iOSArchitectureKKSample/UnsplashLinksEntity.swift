//
//  UnsplashLinksEntity.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct Links: Codable {
    let selfLink, html, photos, likes, portfolio: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html, photos, likes, portfolio
    }
}
