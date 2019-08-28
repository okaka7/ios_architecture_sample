//
//  CollectionUIValueObject.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct CollectionUIValueObject {
    let id: Int
    let title: String
    let description: String?
    //let publishedAt, updatedAt: String
    let curated, featured: Bool
    let totalPhotos: Int
    let purplePrivate: Bool
    let shareKey: String
    //let tags: [Tag]
    //let links: UnsplashCollectionVOLinks
    let user: UnsplashUserEntity
    let coverPhoto: CoverPhoto
    let previewPhotos: [Photo]
}
