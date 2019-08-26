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
    func fetchPopularPhotos(page:Int, photoEntities: [UnsplashPhotoEntity]) -> [UnsplashPhotoEntity]
    func searchPhotos(query: String) -> [UnsplashPhotoEntity]
}

protocol PhotoPrepareUseCaseOutputPort {
    func setTopImages(_ images: [PhotoObject])
    func setCategoryImage(_ image: [PhotoObject], category: Category)
}

final class PhotoPrepareUseCase: PhotoPrepareUseCaseInputPort {
    let repository: FetchPhotoRepository
    let disposeBag: DisposeBag
    
    init(repository: FetchPhotoRepository) {
        self.repository = repository
        self.disposeBag = DisposeBag()
    }
    func fetchPopularPhotos(page:Int = 1,
                            photoEntities: [UnsplashPhotoEntity] = [UnsplashPhotoEntity]())
                            ->
                            [UnsplashPhotoEntity] {
        var photoEntities = photoEntities
        repository.fetchPhotos(page: page, perPage: 30, orderBy: .popular)
            .subscribe(
                onSuccess: {elements in
                    let passingElements = elements.filter {
                        $0.heightRatioToWidth <= 1.6 && $0.heightRatioToWidth >= 1.4
                    }
                    photoEntities.append(contentsOf:passingElements)
                    
                },
                onError: { error in
                    
                })
            .disposed(by: disposeBag)
        if photoEntities.count < 20 {
            return fetchPopularPhotos(page: page + 1, photoEntities: photoEntities)
        } else {
            return photoEntities
        }
    }
    
    func searchPhotos(query: String) -> [UnsplashPhotoEntity] {
        var photos: [UnsplashPhotoEntity]
        repository.searchPhotos(query: query,
                                page: 1,
                                perPage: 30,
                                orientation: .portraint)
            .subscribe(onSuccess: { result in
                photos = result.results
            },
            onError: { error in
                
            })
        .disposed(by: disposeBag)
        return photos
    }
    
    
}
