//
//  UnsplashPhotoEntity.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/31.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol PhotoObject {}

struct UnsplashPhotoEntity: PhotoObject, Codable {
    let id: String
    //, createdAt, updatedAt
    let width, height: Int
    let color, description, altDescription: String?
    let urls: Urls
    let links: UnsplashPhotoVOLinks
    let categories: [String?]
//    let sponsored: Bool
//    let sponsoredBy: UnsplashUserValueObject
//    let sponsoredImpressionsID: String
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String?]
    let user: UnsplashUserEntity
   // let sponsorship: Sponsorship

    enum CodingKeys: String, CodingKey {
        case id
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
        case width, height, color, description
        case altDescription = "alt_description"
        case urls, links, categories//, sponsored
//        case sponsoredBy = "sponsored_by"
//        case sponsoredImpressionsID = "sponsored_impressions_id"
        case likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
      //  case user//, sponsorship
    }
}

extension UnsplashPhotoEntity {
    var heightRatioToWidth: Float {
        return Float(height) / Float(width)
    }
}

struct UnsplashPhotoVOLinks: Codable {
    let purpleSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case purpleSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

struct ProfileImage: Codable {
    let small, medium, large: String
}

struct Sponsorship: Codable {
    let impressionsID, tagline: String
    let sponsor: UnsplashUserEntity

    enum CodingKeys: String, CodingKey {
        case impressionsID = "impressions_id"
        case tagline, sponsor
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: Convenience initializers

extension UnsplashPhotoEntity {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(UnsplashPhotoEntity.self, from: data) else {
            return nil
        }
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

extension UnsplashPhotoVOLinks {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(UnsplashPhotoVOLinks.self, from: data) else { return nil }
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
        guard let data = self.jsonData else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

extension Sponsorship {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Sponsorship.self, from: data) else { return nil }
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

extension Urls {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Urls.self, from: data) else { return nil }
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
