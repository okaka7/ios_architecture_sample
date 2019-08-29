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

protocol PhotoPrepareUseCaseInputPort: class {
    var output: PhotoPrepareUseCaseOutputPort { get }
    func fetchPopularPhotos(page: Int, photoEntities: [UnsplashPhotoEntity])
    func searchPhotos(query: String, page: Int)
}

protocol PhotoPrepareUseCaseOutputPort: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: UnsplashPhotoEntity, category: Category)
}

final class PhotoPrepareUseCase: PhotoPrepareUseCaseInputPort {
    let repository: FetchPhotoRepository
    let output: PhotoPrepareUseCaseOutputPort
    let disposeBag: DisposeBag
    var count = 0
    
    init(repository: FetchPhotoRepository,
         output: PhotoPrepareUseCaseOutputPort) {
        self.repository = repository
        self.disposeBag = DisposeBag()
        self.output = output
    }
    func fetchPopularPhotos(page: Int = 1,
                            photoEntities: [UnsplashPhotoEntity] = [UnsplashPhotoEntity]())
                             {
        
        var photoEntities = photoEntities
        repository.fetchPhotos(page: page, perPage: 50, orderBy: .popular)
            .map { $0.filter { $0.heightRatioToWidth <= 1.6
                                && $0.heightRatioToWidth >= 1.4 }}
            .do(onSuccess: { photoEntities.append(contentsOf: $0) })
            .subscribe(
                onSuccess: {[weak self] elements in
                    if photoEntities.count < 20 {
                        self?.fetchPopularPhotos(page: page + 1,
                                                 photoEntities: photoEntities)
                    } else {
                        self?.output.setTopImages(photoEntities)
                    }
                },
                onError: { error in
                    #if DEBUG
                        log.debug(error)
                    #endif
                })
            .disposed(by: disposeBag)
        
    }
    
    func searchPhotos(query: String, page: Int) {
        repository.searchPhotos(query: query,
                                page: page,
                                perPage: 10,
                                orientation: .portraint)
            .map { $0.results.filter { $0.heightRatioToWidth <= 1.6
                && $0.heightRatioToWidth >= 1.4 }}
            .subscribe(onSuccess: {[weak self] result in
                if result.isEmpty {
                    self?.searchPhotos(query: query, page: page + 1)
                } else {
                    self?.output.setCategoryImage( result.first!, category: .animal)
                }
            },
            onError: { error in
                #if DEBUG
                    log.debug(error)
                #endif
            })
        .disposed(by: disposeBag)
    }
}
