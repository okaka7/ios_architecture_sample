//
//  ImageUIValueObject.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct PhotoUIOutputData {
    let id: String
    let width, height: Int
    let ratioOfWidthToHeight: Float
    //let color: String
    let description, altDescription: String?
    
    //let categories: [String?]
    //let likes: Int
    //let likedByUser: Bool
    let currentUserCollections: [String?]
    let user: UnsplashUserEntity?
    var photoURL: URL {
        return URL(string: urls.small)!
    }
    var downloadURL: URL {
        return URL(string: links.download)!
    }
    private let urls: Urls
    private let links: UnsplashPhotoVOLinks
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

extension PhotoUIOutputData {
    var isSuitableForTopImage: Bool {
        return self.heightRatioToWidth <= 1.5 && self.heightRatioToWidth >= 1.4
    }
    private var heightRatioToWidth: Float {
        return Float(height) / Float(width)
    }
}
