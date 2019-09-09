//
//  SearchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

enum Category: String, CaseIterable {
    
    case nature
    case travel
    case animal
    case fashion
    case art
    case architecture
    
    var cacheKey: CacheKey<UnsplashPhotoEntity> {
        switch self {
        case .nature:
            return .natureCategory
        case .travel:
            return .travelCategory
        case .animal:
            return .animalCategory
        case .fashion:
            return .fashionCategory
        case .art:
            return .artCategory
        case .architecture:
            return .artCategory
        }
    }
    
    var id: String {
        switch self {
        case .nature:
            return "T2l1NxKOsjY"
        case .travel:
            return "hFXZ5cNfkOk"
        case .animal:
            return "8kA9TKg6DKw"
        case .fashion:
            return "1GwsEHtkhVg"
        case .art:
            return "o3NLIY0_Qhc"
        case .architecture:
            return "16f8y0DswPc"
        }
    }
}

protocol SearchUseCaseInputPort: PhotoSelectable {
    func slideCategoryView(up: Bool)
    func fetchCategoryPhotos()
    func searchUseCase(query: String)
    func selectPhoto(_ photo: PhotoUIEntity)
}

protocol SearchUsecaseOutputPort: PhotoTransitionable {
    func setupCategoryPhotos(photos: [PhotoObject])
    func slideCategoryView(up: Bool)
    func showSearchResult(photos: [PhotoObject])
}

final class SearchUseCase: SearchUseCaseInputPort {
    
    let repository: FetchPhotoRepository
    let disposeBag: DisposeBag = DisposeBag()
    
    init(repository: FetchPhotoRepository) {
        self.repository = repository
        
    }
    
    func slideCategoryView(up: Bool) {
        
    }
    
    func fetchCategoryPhotos() {
        
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
    
    func selectPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func selectImage(id: String) {
        
    }
}
