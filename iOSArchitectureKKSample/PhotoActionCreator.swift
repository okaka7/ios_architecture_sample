//
//  HomeVCActionCreator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


final class PhotoActionCreator {
    static let shared = PhotoActionCreator()
    
    private let dipatcher: PhotoDispatcher
    
    init(dispatcher: PhotoDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func addPhotoToLikes(photo: Int) {
        
    }
    
    func removePhotoToLikes(photo: Int) {
        
    }
    
    func addPhotoToCollection(photo: Int, to collection: Int) {
        
    }
    
    func removePhotoFromCollection(photo: Int, from collection: Int) {
        
    }
    
}
