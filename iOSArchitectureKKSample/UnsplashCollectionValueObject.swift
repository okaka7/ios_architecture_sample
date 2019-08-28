//
//  UnsplashCollectionEntity.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol CollectionObject {}

struct UnsplashCollectionValueObject: CollectionObject, Codable {
    let id: Int
    let title: String
    let description: String?
    let publishedAt, updatedAt: String
    let curated, featured: Bool
    let totalPhotos: Int
    let purplePrivate: Bool
    let shareKey: String
    let tags: [Tag]
    let links: UnsplashCollectionVOLinks
    let user: UnsplashUserEntity
    let coverPhoto: CoverPhoto
    let previewPhotos: [Photo]

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case curated, featured
        case totalPhotos = "total_photos"
        case purplePrivate = "private"
        case shareKey = "share_key"
        case tags, links, user
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
    }
}

struct CoverPhoto: Codable {
    let id, createdAt, updatedAt: String
    let width, height: Int
    let color: String
    let description, altDescription: String?
    let urls: Urls
    let links: CoverPhotoLinks
    let categories: [String?]
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String?]
    let user: UnsplashUserEntity

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color, description
        case altDescription = "alt_description"
        case urls, links, categories, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case user
    }
}

struct CoverPhotoLinks: Codable {
    let purpleSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case purpleSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

struct UnsplashCollectionVOLinks: Codable {
    let purpleSelf, html, photos, related: String

    enum CodingKeys: String, CodingKey {
        case purpleSelf = "self"
        case html, photos, related
    }
}

struct Tag: Codable {
    let title: String
}

// MARK: Convenience initializers

extension UnsplashCollectionValueObject {
    init?(data: Data) {
        guard let me = try? JSONDecoder()
            .decode(UnsplashCollectionValueObject.self,
                    from: data) else {
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

extension CoverPhoto {
    init?(data: Data) {
        guard let me = try? JSONDecoder()
            .decode(CoverPhoto.self,
                    from: data)
            else {
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

extension CoverPhotoLinks {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(CoverPhotoLinks.self, from: data) else { return nil }
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

extension UnsplashCollectionVOLinks {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(UnsplashCollectionVOLinks.self, from: data) else { return nil }
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

extension Tag {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Tag.self, from: data) else { return nil }
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
