//
//  ImageUIValueObject.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct PhotoUIEntity {
    let id: String
    let width, height: Int
    let ratioOfWidthToHeight: Float
    //let color: String
    let description, altDescription: String?
    let urls: Urls
    let links: UnsplashPhotoVOLinks
    //let categories: [String?]
    //let likes: Int
    //let likedByUser: Bool
    let currentUserCollections: [String?]
    let user: UnsplashUserEntity?
    //let sponsorship: Sponsorship
    
    init(photo: UnsplashPhotoEntity) {
        self.id = photo.id
        self.width = photo.width
        self.height = photo.height
        self.ratioOfWidthToHeight = Float(photo.width) / Float(photo.height)
        self.description = photo.description
        self.altDescription = photo.altDescription
        self.urls = photo.urls
        self.links = photo.links
        self.currentUserCollections = photo.currentUserCollections
        self.user = photo.user
    }
}

extension PhotoUIEntity {
    var isSuitableForTopImage: Bool {
        return self.heightRatioToWidth <= 1.5 && self.heightRatioToWidth >= 1.4
    }
    private var heightRatioToWidth: Float {
        return Float(height) / Float(width)
    }
}
