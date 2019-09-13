//
//  PhotoUIEntityList.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct PhotoUIList {
    let list: [PhotoUIEntity]
    var count: Int { return list.count }
    
    init() {
        self.list = [PhotoUIEntity]()
    }
    
    init(photoUIList: [PhotoUIEntity]) {
        self.list = photoUIList
    }
    
    init(photoList: [UnsplashPhotoEntity]) {
        self.list = photoList.map(PhotoUIEntity.init(photo:))
    }
    
    static func +(lhs: PhotoUIList, rhs: PhotoUIList) -> PhotoUIList {
        let list: [PhotoUIEntity] = lhs.list + rhs.list
        return .init(photoUIList: list)
    }
}

extension PhotoUIList {
    var warpingPhotoFilter: PhotoUIList {
        let list: [PhotoUIEntity] = self.list.filter{ $0.isSuitableForTopImage }
        return .init(photoUIList: list)
    }
}
