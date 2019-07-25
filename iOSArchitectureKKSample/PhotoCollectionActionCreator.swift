//
//  PhotoCollectionActionCreator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


final class PhotoCollectionActionCreator {
    static let shared = PhotoCollectionActionCreator()
    
    private let dipatcher: FavoritePhotoDispatcher
    
    init(dispatcher: FavoritePhotoDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func addPhotoIntoCollection(photo: Int, collection: Int) {
        
    }
    
    func removePhotoFromCollection(photo: Int, collection: Int) {
        
    }
    
    func createCollection(name: String) {
        
    }
    
    func deleteCollection(collection: Int) {
        
    }
    
}
