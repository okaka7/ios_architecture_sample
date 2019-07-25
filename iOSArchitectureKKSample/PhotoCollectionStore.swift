//
//  PhotoCollectionStore.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class PhotoCollectionStore {
    static let shared = PhotoCollectionStore()
    
    var photoCollection: [Int: [Int]?] {
        return _photoCollection.value
    }
    
    var photosCollection: Observable<[Int: [Int]?]> {
        return _photoCollection.asObservable()
    }
    
    private let _photoCollection = BehaviorRelay<[Int: [Int]?]> (value: [0: nil])
    
    private let disposeBag = DisposeBag()
    
    init(dispatcher: PhotoCollectionDispatcher = .shared) {
        dispatcher
            .photoCollection
            .bind(to: _photoCollection)
            .disposed(by: disposeBag)
    }
}
