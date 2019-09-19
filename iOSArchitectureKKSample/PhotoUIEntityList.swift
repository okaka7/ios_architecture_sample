//
//  PhotoUIEntityList.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct PhotoUIList {
    let list: [PhotoUIOutputData]
    var count: Int { return list.count }
    
    init() {
        self.list = [PhotoUIOutputData]()
    }
    
    init(photoUIList: [PhotoUIOutputData]) {
        self.list = photoUIList
    }
    
    init(photoList: [UnsplashPhotoEntity]) {
        self.list = photoList.map(PhotoUIOutputData.init(photo:))
    }
    
    static func +(lhs: PhotoUIList, rhs: PhotoUIList) -> PhotoUIList {
        let list: [PhotoUIOutputData] = lhs.list + rhs.list
        return .init(photoUIList: list)
    }
}


