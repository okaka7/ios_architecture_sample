//
//  UserUIValueObject.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct UserUIValueObject {
    let id: String
    //let updatedAt: Date
    let username, name: String
    let twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: Links
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int
    //let acceptedTos, followedByUser: Bool
    let photos: [Photo]
    //let badge: Badge
    //let downloads: Int
    //let tags: Tags?
    let followersCount, followingCount: Int
    let allowMessages: Bool
    //let numericID: Int
}
