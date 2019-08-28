//
//  Repository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Photo
protocol FetchPhotoRepository {
    
    func fetchPhoto(id: String) -> Single<UnsplashPhotoTarget.Response>
    func fetchPhotos(page: Int,
                     perPage: Int,
                     orderBy: OrderBy) -> Single<UnsplashPhotosTarget.Response>
    func searchPhotos(query: String,
                      page: Int,
                      perPage: Int,
                      orientation: PhotoOrientation) -> Single<UnsplashSearchPhotosTarget.Response>
}

protocol LikePhotoRepository {
    func likePhoto() -> PhotoObject
    func removelikePhoto() -> PhotoObject
}

protocol DownloadPhotoRepository {
    func downloadPhoto(id: String) -> PhotoDownloadURLObject
}

// MARK: Collection

protocol CollectionRepository {
    func addPhoto(into collectionID: String) -> [PhotoObject]
    func removePhoto(from collectionID: String) -> [PhotoObject]
}

protocol AccountRepository {
    func fetchAccount() -> Single<UnsplashAccountTarget.Response>
    func fetchUserPhotos(userName name: String) -> Single<UnsplashUserPhotosTarget.Response>
    func fetchUserCollections(userName name: String) -> Single<UnsplashUserCollectionsTarget.Response>
    func fetchPortfolioURL(userName name: String) -> Single<UnsplashUserPortfolioTarget.Response>
}

protocol UserRepository {
    func fetchUserRepository() -> UserObject
    func fetchPhotos() -> [PhotoObject]
    func fetchCollection() -> [CollectionObject]
    func fetchPortfolioURL() -> PortfolioURLObject
}
