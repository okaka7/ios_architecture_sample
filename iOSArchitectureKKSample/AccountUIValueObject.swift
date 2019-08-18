//
//  AccountUIValueObject.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct AccountUIValueObject {
    let id: String
    let username: String
    let name: String
    let twitterUsername, instagramUsername: String?
    let portfolioURL: String?
    let bio: String?
    let location: String?
    let links: Links
    let profileImage: ProfileImage
    let totalCollections, totalPhotos: Int
    let totalLikes: Int
    let acceptedTos: Bool
    let followedByUser: Bool
    let photos: [Photo]
//    let badge: Badge?
//    let downloads: Int
//    let tags: Tags
    let followersCount, followingCount: Int
    let allowMessages: Bool
//    let numericID: Int
//    let uid: String
//    let uploadsRemaining: Int
//    let unlimitedUploads: Bool
//    let email: String?
}
