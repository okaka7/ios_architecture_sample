//
//  SearchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchUseCaseInputPort: PhotoSelectable {
    func fetchPopularPhotos(page: Int) -> Single<UnsplashPhotosTarget.Response>
    func slideCategoryView(up: Bool)
    func searchUseCase(query: String)
    func selectPhoto(_ photo: PhotoUIEntity)
}

protocol SearchUsecaseOutputPort: PhotoTransitionable {
    func setupCategoryPhotos(photos: [PhotoObject])
    func slideCategoryView(up: Bool)
    func showSearchResult(photos: [PhotoObject])
}

final class SearchUseCase: SearchUseCaseInputPort {
    
    let repository: PhotoRepository
    let disposeBag: DisposeBag = DisposeBag()
    
    init(repository: PhotoRepository) {
        self.repository = repository
        
    }
    
    func slideCategoryView(up: Bool) {
        
    }
    
    func searchUseCase(query: String) {
//        repository.searchPhotos(query: query,
//                                page: 1,
//                                perPage: 50,
//                                orientation: .portraint)
//        .subscribe(onSuccess: <#T##((SearchPhotoReponseValueObject) -> Void)?##((SearchPhotoReponseValueObject) -> Void)?##(SearchPhotoReponseValueObject) -> Void#>,
//                   onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>)
//        .disposed(by: disposeBag)
    }
    
    func fetchPopularPhotos(page: Int = 1) -> Single<UnsplashPhotosTarget.Response> {
        return repository.fetchPhotos(page: page, perPage: 50, orderBy: .popular)
    }
    
    func selectPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func selectImage(id: String) {
        
    }
}
