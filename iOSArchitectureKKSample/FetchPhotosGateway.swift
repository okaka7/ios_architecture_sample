//
//  FetchPhotosGateway.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

struct FetchPhotoGateWay: FetchPhotoRepository {
    
    let client: UnsplashPhotoClient
    
    init(client: UnsplashPhotoClient) {
        self.client = client
    }
    
    func fetchPhoto(id: String) -> Single<UnsplashPhotoTarget.Response> {
        return client.requestPhoto(id: id)
    }
    func fetchPhotos(page: Int,
                     perPage: Int,
                     orderBy: OrderBy) -> Single<UnsplashPhotosTarget.Response> {
        return client.requestPhotos(page: page,
                                    perPage: perPage,
                                    orderBy: orderBy)
    }
    func searchPhotos(query: String,
                      page: Int,
                      perPage: Int,
                      orientation: PhotoOrientation) -> Single<UnsplashSearchPhotosTarget.Response> {
        return client.requestSearchPhotos(query: query,
                                          page: page,
                                          perPage: perPage,
                                          orientation: orientation)
    }
}
