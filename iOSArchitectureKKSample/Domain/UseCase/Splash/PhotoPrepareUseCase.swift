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

protocol PhotoPrepareUseCaseInputPort: class {
    var output: PhotoPrepareUseCaseOutputPort! { get set }
    func fetchPopularPhotos(page: Int, photoEntities: [UnsplashPhotoEntity])
    func searchPhotos(query: String, page: Int)
}

protocol PhotoPrepareUseCaseOutputPort {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: UnsplashPhotoEntity, category: Category)
}

final class PhotoPrepareUseCase: PhotoPrepareUseCaseInputPort {
    let repository: FetchPhotoRepository
    var output: PhotoPrepareUseCaseOutputPort!
    let disposeBag: DisposeBag
    
    init(repository: FetchPhotoRepository) {
        self.repository = repository
        self.disposeBag = DisposeBag()
    }
    func fetchPopularPhotos(page: Int = 1,
                            photoEntities: [UnsplashPhotoEntity] = [UnsplashPhotoEntity]())
                             {
        var photoEntities = photoEntities
                                
        repository.fetchPhotos(page: page, perPage: 30, orderBy: .popular)
            .subscribe(
                onSuccess: {[weak self]elements in
                    let passingElements = elements.filter {
                        $0.heightRatioToWidth <= 1.6 && $0.heightRatioToWidth >= 1.4
                    }
                    photoEntities.append(contentsOf: passingElements)
                    if photoEntities.count < 20 {
                        self?.fetchPopularPhotos(page: page + 1, photoEntities: photoEntities)
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
            .subscribe(onSuccess: {[weak self] result in
                let passingElements = result.results.filter {
                    $0.heightRatioToWidth <= 1.6 && $0.heightRatioToWidth >= 1.4
                }
                if passingElements.isEmpty {
                    self?.searchPhotos(query: query, page: page + 1)
                } else {
                    self?.output.setCategoryImage( passingElements.first!, category: .animal)
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
