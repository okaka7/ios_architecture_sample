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
    
    private let dipatcher: HomeTabDispatcher
    
    init(dispatcher: HomeTabDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func selectImage(image: Int) {
        
    }
    
    func selectUser(photo: Int) {
        
    }
    
    func downloadPhoto(photo: Int) {
        
    }
    
}
