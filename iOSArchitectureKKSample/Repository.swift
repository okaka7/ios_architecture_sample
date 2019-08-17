//
//  Repository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct Repository {}


protocol FetchPhotoRepository {
    func fetchPhoto(id: String) -> PhotoObject
}

protocol FetchPhotosRepository {
    func fetchPhots() -> [PhotoObject]
}

protocol LikePhotoRepository {
    func likePhoto() -> PhotoObject
    func unlikePhoto() -> PhotoObject
}

protocol DownloadPhotoRepository {
    func downloadPhoto(id: String) -> PhotoDownloadURLObject
}

protocol SearchPhotoRepository {
    func searchPhotos(query: String) -> SearchPhotoResultObject
}
