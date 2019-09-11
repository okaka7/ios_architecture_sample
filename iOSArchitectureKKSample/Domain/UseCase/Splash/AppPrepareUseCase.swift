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
//    func fetchPopularPhotos(page: Int) -> Single<UnsplashPhotosTarget.Response>
//    func fetchAccount() -> Single<UnsplashAccountTarget.Response>
}

protocol PhotoPrepareUseCaseOutputPort: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: [Category : UnsplashPhotoEntity])
}

final class AppPrepareUseCase: PrepareAppUseCaseInputPort {
//    private let photoRepository: PhotoRepository
//    private let accountRepository: AccountRepository
    
//    init(photoRepository: PhotoRepository,
//         accountRepository: AccountRepository) {
////        self.photoRepository = photoRepository
////        self.accountRepository = accountRepository
//    }
    
//    func fetchPopularPhotos(page: Int = 1) -> Single<UnsplashPhotosTarget.Response> {
//        return photoRepository.fetchPhotos(page: page, perPage: 50, orderBy: .popular)
//    }
//
//    func fetchAccount() -> Single<UnsplashAccountTarget.Response> {
//        return accountRepository.fetchAccount()
//    }
}
