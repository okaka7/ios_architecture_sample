//
//  UserAccountUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol 

protocol UserAccountUseCase: PhotoSelectable {
    func selectPhotos()
    func selectCollections()
    func selectLikes()
    
}
