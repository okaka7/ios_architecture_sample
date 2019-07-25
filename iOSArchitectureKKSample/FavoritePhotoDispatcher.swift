//
//  FavoritePhotoDispatcher.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class FavoritePhotoDispatcher {
    static let shared = FavoritePhotoDispatcher()
    
    let favoritePhotos = PublishRelay<[Int]>()
}
