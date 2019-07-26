//
//  HomeTabActionCreator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


final class HomeTabActionCreator {
    static let shared = HomeTabActionCreator()
    
    private let dipatcher: FavoritePhotoDispatcher
    
    init(dispatcher: FavoritePhotoDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func selectCategory(category: Int) {
        
    }
    
    func switchTopImage(photo: Int) {
        
    }
    
    func slideCategoryView(proceeding: Float) {
        
    }
    
}
