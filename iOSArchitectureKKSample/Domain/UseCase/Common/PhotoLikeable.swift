//
//  PhotoLikable.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol PhotoLikeable {
    func likePhoto(id: String)
    func unlikePhoto(id: String)
}

protocol PhotoLikeUpdatale {
    func likePhoto(id: String)
    func unlikePhoto(id: String)
}
