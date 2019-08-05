//
//  UnsplashUserEntity.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct UnsplashUserEntity: Codable {
    let id, updatedAt, username, firstName: String
    let lastName, email: String
    let portfolioURL: String?
    let bio: String?
    let location: String?
    let totalLikes, totalPhotos, totalCollections: Int
    let followedByUser: Bool
    let downloads, uploadsRemaining: Int
    let instagramUsername,twitterUsername: String?
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case followedByUser = "followed_by_user"
        case downloads
        case uploadsRemaining = "uploads_remaining"
        case instagramUsername = "instagram_username"
        case email, links
    }
}



// MARK: Convenience initializers

extension UnsplashUserEntity {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(UnsplashUserEntity.self, from: data) else { return nil
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



// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
