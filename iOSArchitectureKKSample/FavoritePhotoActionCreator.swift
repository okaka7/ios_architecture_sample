//
//  LikeActionCreator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

final class FavoritePhotoActionCreator {
    static let shared = FavoritePhotoActionCreator()
    
    private let dipatcher: FavoritePhotoDispatcher
    
    init(dispatcher: FavoritePhotoDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func addFavoritePhoto(photo: Int) {
        
    }
    
    func removeFavoritePhoto(photo: Int) {
        
    }
    
    func loadFavoritePhotos() {
        
    }
    
}

