//
//  AccountUIEntity.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct AccountUIEntity {
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
    //    let totalLikes: Int
    //    let acceptedTos: Bool
    //    let followedByUser: Bool
    let photos: [Photo]
    //    let badge: Badge?
    //    let downloads: Int
    //    let tags: Tags
    //    let followersCount, followingCount: Int
    //    let allowMessages: Bool
    //    let numericID: Int
    //    let uid: String
    //    let uploadsRemaining: Int
    //    let unlimitedUploads: Bool
    //    let email: String?
    
    init(account: UnsplashAccountEntity) {
        self.id = account.id
        self.username = account.username
        self.name = account.name
        self.twitterUsername = account.twitterUsername
        self.instagramUsername = account.instagramUsername
        self.portfolioURL = account.portfolioURL
        self.bio = account.bio
        self.location = account.location
        self.links = account.links
        self.profileImage = account.profileImage
        self.totalCollections = account.totalCollections
        self.totalPhotos = account.totalPhotos
        self.photos = account.photos
    }
}
