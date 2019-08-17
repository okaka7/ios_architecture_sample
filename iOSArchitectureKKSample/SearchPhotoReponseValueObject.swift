//
//  SearchPhotoReponse.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol SearchPhotoResultObject {}

struct SearchPhotoReponseValueObject: SearchPhotoResultObject, Codable {
    let total, totalPages: Int
    let results: [UnsplashPhotoValueObject]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
