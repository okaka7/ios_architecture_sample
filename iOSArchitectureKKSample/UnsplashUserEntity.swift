//
//  UnsplashUserEntity.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol UserObject {}

struct UnsplashUserEntity: UserObject, Codable {
    let id: String
    let updatedAt: String
    let username, name, firstName: String
    let lastName: String?
    let twitterUsername, instagramUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: Links
    let profileImage: ProfileImage
    let totalCollections, totalLikes, totalPhotos: Int
    let acceptedTos: Bool
    let followedByUser: Bool?
    let photos: [Photo]?
    let badge: Badge?
    let downloads: Int?
    let tags: Tags?
    let followersCount, followingCount: Int?
    let allowMessages: Bool?
    let numericID: Int?
    
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
        case photos, badge, downloads, tags
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case allowMessages = "allow_messages"
        case numericID = "numeric_id"
    }
}

// MARK: Convenience initializers

extension UnsplashUserEntity {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(UnsplashUserEntity.self, from: data) else {
            return nil
        }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else {
            return nil
        }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

struct Links: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

extension Links {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Links.self, from: data) else { return nil }
        self = me
    }
    
    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }
    
    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }
    
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
