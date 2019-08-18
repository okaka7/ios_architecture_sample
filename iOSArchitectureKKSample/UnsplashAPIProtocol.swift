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
    static func requestPhotos() -> Single<UnsplashPhotosTarget.Response>
    static func requestLikePhoto(id: String, isLike: Bool) -> Single<UnsplashLikePhotoTarget.Response>
    
    static func requestDownloadPhotoURL(id: String) -> Single<UnsplashDownloadPhotoTarget.Response>
    
    static func requestSearchPhots(query: String) -> Single<UnsplashSearchPhotosTarget.Response> 
}

protocol UnsplashCollectionClient {
    static func requestCollection(id : String) -> Single<UnsplashCollectionTarget.Response>
    
    static func requestCollectionPhotos(id : String) -> Single<UnsplashCollectionPhotosTarget.Response>
    
    static func requestRelatedCollections(id : String) -> Single<UnsplashRelatedCollectionsTarget.Response>
    
    static func requestEditPhotoInCollection(isAdding: Bool,
                                             collectionID: String,
                                             photoID: String) -> Single<UnsplashEditPhotoInCollectionTarget.Response> 
}

protocol UnsplashUserAccountClient {
    static func requestAccount() -> Single<UnsplashAccountTarget.Response>
    
    static func requestUser(userName name: String) -> Single<UnsplashUserTarget.Response>
    
    static func requestUserLikes(userName name: String) -> Single<UnsplashUserLikesTarget.Response>
    
    static func requestUserPortfolio(userName name: String) -> Single<UnsplashUserPortfolioTarget.Response>
    
    static func requestUserCollections(userName name: String) -> Single<UnsplashUserCollectionsTarget.Response> 
}
