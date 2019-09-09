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
    func searchPhotos(query: [Category], page: Int)
    func loadCategoryPhoto(_ category: Category) -> Single<UnsplashPhotoEntity>
    func fetchCategoryPhoto(_ category: Category) -> Single<UnsplashPhotoEntity>
    func fetchAccount()
}

protocol PhotoPrepareUseCaseOutputPort: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: [Category : UnsplashPhotoEntity])
}

final class AppPrepareUseCase: PrepareAppUseCaseInputPort {
  
    private let dataStore: LocalCache
    private let repository: FetchPhotoRepository
    let disposeBag: DisposeBag
    var count = 0
    
    init(repository: FetchPhotoRepository,
         dataStore: LocalCache,
        disposeBag: DisposeBag = DisposeBag()) {
        self.repository = repository
        self.dataStore = dataStore
        self.disposeBag = disposeBag
    }
    
    func fetchPopularPhotos(page: Int = 1) -> Single<UnsplashPhotosTarget.Response> {
        return repository.fetchPhotos(page: page, perPage: 50, orderBy: .popular)
    }
    
    func loadCategoryPhoto(_ category: Category) -> Single<UnsplashPhotoEntity> {
        return dataStore.rx.fetch(key: <#T##CacheKey<CacheSettable & LocalCacheGettable>#>)
    }
    
    func fetchCategoryPhoto(_ category: Category) -> Single<UnsplashPhotoEntity> {
        return repository.fetchPhoto(id: <#T##String#>)
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
                    //self?.output.setCategoryImage(result)
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
