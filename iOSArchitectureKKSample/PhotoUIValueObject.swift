//
//  ImageUIValueObject.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct PhotoUIValueObject {
    let id: String
    //let width, height: Int
    let ratioOfWidthToHeight: Float
    let color, description, altDescription: String
    let urls: Urls
    //let links: UnsplashPhotoVOLinks
    //let categories: [String?]
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String?]
    let user: UnsplashUserEntity
    //let sponsorship: Sponsorship
}
