//
//  Repository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

// MARK: Photo
protocol FetchPhotoRepository {
    func fetchPhoto(id: String) -> PhotoObject
}

protocol FetchPhotosRepository {
    func fetchPhots() -> [PhotoObject]
}

protocol LikePhotoRepository {
    func likePhoto() -> PhotoObject
    func removelikePhoto() -> PhotoObject
}

protocol DownloadPhotoRepository {
    func downloadPhoto(id: String) -> PhotoDownloadURLObject
}

protocol SearchPhotoRepository {
    func searchPhotos(query: String) -> SearchPhotoResultObject
}

// MARK: Collection

protocol CollectionRepository {
    func addPhoto(into collectionID: String) -> [PhotoObject]
    func removePhoto(from collectionID: String) -> [PhotoObject]
}

protocol AccountRepository {
    func fetchAccount() -> AccountObject
    func fetchPhotos() -> [PhotoObject]
    func fetchCollection() -> [CollectionObject]
    func fetchPortfolioURL() -> PortfolioURLObject
}

protocol UserRepository {
    func fetchUserRepository() -> UserObject
    func fetchPhotos() -> [PhotoObject]
    func fetchCollection() -> [CollectionObject]
    func fetchPortfolioURL() -> PortfolioURLObject
}
