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
import DataCache

enum FetchTopImagesError: Error {
    case deficientPhotos
}

protocol PrepareAppUseCaseInputPort: class {
    func fetchPopularPhotos(page: Int) -> Single<UnsplashPhotosTarget.Response>
    func fetchAccount() -> Single<UnsplashAccountTarget.Response>
}

protocol PhotoPrepareUseCaseOutputPort: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: [Category : UnsplashPhotoEntity])
}

final class AppPrepareUseCase: PrepareAppUseCaseInputPort {
    private let photoRepository: PhotoRepository
    private let accountRepository: AccountRepository
    let disposeBag: DisposeBag
    
    init(photoRepository: PhotoRepository,
         accountRepository: AccountRepository,
         disposeBag: DisposeBag = DisposeBag()) {
        self.photoRepository = repository
        self.accountRepository = accountRepository
        self.disposeBag = disposeBag
    }
    
    func fetchPopularPhotos(page: Int = 1) -> Single<UnsplashPhotosTarget.Response> {
        return repository.fetchPhotos(page: page, perPage: 50, orderBy: .popular)
    }
    
    func fetchAccount() -> Single<UnsplashAccountTarget.Response> {
        return accountRepository.fetchAccount()
    }
}
