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
    var output: PhotoPrepareUseCaseOutputPort { get }
    func fetchPopularPhotos(page: Int, photoEntities: [UnsplashPhotoEntity])
    func searchPhotos(query: [Category], page: Int)
    func fetchAccount()
}

protocol PhotoPrepareUseCaseOutputPort: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: [Category : UnsplashPhotoEntity])
}

final class AppPrepareUseCase: PrepareAppUseCaseInputPort {
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
            .subscribe(
                onSuccess: {[weak self] elements in
                    photoEntities.append(contentsOf: elements)
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
    
    func searchPhotos(query: [Category], page: Int = 1) {
        var page = page
        let combineSingles: [Observable<UnsplashSearchPhotosTarget.Response>] = query.map {
                                                                repository.searchPhotos(query: $0.rawValue,
                                                                page: 1,
                                                                perPage: 10,
                                                                orientation: .portraint)
                                                                .asObservable()}
        Observable.combineLatest(combineSingles)
            .map { $0.map{ $0.results } }
            .map { $0.map{ $0.filter{ $0.heightRatioToWidth <= 1.6 && $0.heightRatioToWidth >= 1.4 }}}
            .map { $0.map{ $0.first} }
            .map {
                zip(query, $0).reduce(into: Dictionary<Category, UnsplashPhotoEntity?>(),
                                      { result, elements in
                                        result[elements.0] = elements.1
                })}
            .take(1)
            .asSingle()
            .subscribe(onSuccess: {[weak self]  in
                guard let result = $0 as? [Category : UnsplashPhotoEntity] else {
                    self?.searchPhotos(query: query, page: page + 1)
                    return
                }
                    self?.output.setCategoryImage(result)
                },
                onError: { error in
                    #if DEBUG
                    log.debug(error)
                    #endif
            }).disposed(by: disposeBag)
        
    }
    
    func fetchAccount() {
    }
}
