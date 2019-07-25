//
//  FavoritePhotosStore.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class FavoritePhotoStore {
    static let shared = FavoritePhotoStore()
    
    var photos: [Int] {
        return _photos.value
    }
    
    var photosObservable: Observable<[Int]> {
        return _photos.asObservable()
    }

    private let _photos = BehaviorRelay<[Int]> (value: [0])
    
    private let disposeBag = DisposeBag()
    
    init(dispatcher: FavoritePhotoDispatcher = .shared) {
        dispatcher
            .favoritePhotos
            .bind(to: _photos)
            .disposed(by: disposeBag)
    }
}
