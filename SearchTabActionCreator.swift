//
//  HomeTabActionCreator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


final class SearchTabActionCreator {
    static let shared = SearchTabActionCreator()
    
    private let dipatcher: SearchTabDispatcher
    
    init(dispatcher: SearchTabDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func selectImage(image: Int) {
        
    }
    
    func selectUser(user: Int) {
        
    }
    
    func downloadPhoto(image: Int) {
        
    }
}
