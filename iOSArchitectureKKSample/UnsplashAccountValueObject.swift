//
//  UnsplashUserAccountEntity.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/05.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol AccountObject: Codable {}

struct UnsplashAccountValueObject: AccountObject, Codable {
    let id: String
    let updatedAt: Date
    let username: String
    let name, firstName, lastName: String
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
    //let badge: Badge?
    let downloads: Int
    let tags: Tags
    let followersCount, followingCount: Int
    let allowMessages: Bool
    let numericID: Int
    let uid: String
    let uploadsRemaining: Int
    let unlimitedUploads: Bool
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case followedByUser = "followed_by_user"
        case photos, downloads, tags
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case allowMessages = "allow_messages"
        case numericID = "numeric_id"
        case uid
        case uploadsRemaining = "uploads_remaining"
        case unlimitedUploads = "unlimited_uploads"
        case email
    }
}
// MARK: - Tags
struct Tags: Codable {
    let custom, aggregated: [Aggregated]
}

// MARK: - Aggregated
struct Aggregated: Codable {
    let title: String
}
struct Badge: Codable {
    let title: String
    let primary: Bool
    let slug, link: String
}

struct Photo: Codable {
    let id: String
    let urls: Urls
}
