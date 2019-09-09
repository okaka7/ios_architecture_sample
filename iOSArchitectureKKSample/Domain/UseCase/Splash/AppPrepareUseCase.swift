//
//  PhotoFetchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum FetchTopImagesError: Error {
    case deficientPhotos
}

protocol PrepareAppUseCaseInputPort: class {
    func fetchPopularPhotos(page: Int) -> Single<UnsplashPhotosTarget.Response>
   
    func fetchAccount()
}

protocol PhotoPrepareUseCaseOutputPort: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: [Category : UnsplashPhotoEntity])
}

final class AppPrepareUseCase: PrepareAppUseCaseInputPort {
    private let repository: FetchPhotoRepository
    let disposeBag: DisposeBag
    var count = 0
    
    init(repository: FetchPhotoRepository,
         cache: Cache,
        disposeBag: DisposeBag = DisposeBag()) {
        self.repository = repository
        self.disposeBag = disposeBag
    }
    
    func fetchPopularPhotos(page: Int = 1) -> Single<UnsplashPhotosTarget.Response> {
        return repository.fetchPhotos(page: page, perPage: 50, orderBy: .popular)
    }
    

    func fetchAccount() {
    }
}
