//
//  UnsplashAPIProtocol.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

typealias UnsplashClient = UnsplashPhotoClient & UnsplashCollectionClient & UnsplashUserAccountClient

protocol UnsplashPhotoClient {
    func requestPhotos(page: Int,
                       perPage: Int,
                       orderBy: OrderBy) -> Single<UnsplashPhotosTarget.Response>
    func requestLikePhoto(id: String, isLike: Bool) -> Single<UnsplashLikePhotoTarget.Response>
    
    func requestDownloadPhotoURL(id: String) -> Single<UnsplashDownloadPhotoTarget.Response>
    
    func requestSearchPhotos(query: String,
                            page: Int,
                            perPage: Int,
                            orderBy: OrderBy) -> Single<UnsplashSearchPhotosTarget.Response>
}

protocol UnsplashCollectionClient {
    func requestCollection(id : String) -> Single<UnsplashCollectionTarget.Response>
    
    func requestCollectionPhotos(id : String) -> Single<UnsplashCollectionPhotosTarget.Response>
    
    func requestRelatedCollections(id : String) -> Single<UnsplashRelatedCollectionsTarget.Response>
    
    func requestEditPhotoInCollection(isAdding: Bool,
                                             collectionID: String,
                                             photoID: String) -> Single<UnsplashEditPhotoInCollectionTarget.Response> 
}

protocol UnsplashUserAccountClient {
    func requestAccount() -> Single<UnsplashAccountTarget.Response>
    
    func requestUser(userName name: String) -> Single<UnsplashUserTarget.Response>
    
    func requestUserLikes(userName name: String) -> Single<UnsplashUserLikesTarget.Response>
    
    func requestUserPortfolio(userName name: String) -> Single<UnsplashUserPortfolioTarget.Response>
    
    func requestUserCollections(userName name: String) -> Single<UnsplashUserCollectionsTarget.Response> 
}
