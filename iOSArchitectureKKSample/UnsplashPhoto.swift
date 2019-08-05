//
//  UnsplashPhoto.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

import Moya

struct UnsplashPhoto: UnsplashAPITargetType {
    
    typealias Response = String
    
    let path: String = "/photos"
    let method: Moya.Method = .get
    let code: String
    var task: Task {
        return .requestPlain
    }
    
   
}
