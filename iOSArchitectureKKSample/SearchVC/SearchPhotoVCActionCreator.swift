//
//  HomeVCActionCreator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


final class SearchPhotoVCActionCreator {
    static let shared = SearchPhotoVCActionCreator()
    
    private let dipatcher: SearchPhotoVCDispatcher
    
    init(dispatcher: SearchPhotoVCDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func selectCategory(photo: Int) {
        
    }
    
    func reloadPhoto() {
        
    }
    
    func loadMore() {
        
    }
    
}
