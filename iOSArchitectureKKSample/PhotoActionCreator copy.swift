//
//  HomeVCActionCreator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


final class UserActionCreator {
    static let shared = UserActionCreator()
    
    private let dipatcher: UserDispatcher
    
    init(dispatcher: UserDispatcher = .shared) {
        self.dipatcher = dispatcher
    }
    
    func followUser(user: Int) {
        
    }
    
    func unfollowUsr(user: Int) {
        
    }
}
