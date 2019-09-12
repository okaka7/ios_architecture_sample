//
//  SearchViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewModelType: class {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
}

extension SearchViewModelType where Self: SearchViewModelInputs {
    var inputs: SearchViewModelInputs { return self }
}

extension SearchViewModelType where Self: SearchViewModelOutputs {
    var outputs: SearchViewModelOutputs { return self }
}

protocol SearchViewModelInputs: class {
    func fetchPopularPhotos(page: Int)
    func searchPhotos(query: String)
}

extension SearchViewModelInputs {
    func fetchPopularPhotos(page: Int = 1) { }
}

protocol SearchViewModelOutputs: class {
    var popluarPhotosObservable: Single<PopularPhotoList?> { get }
}

final class SearchViewModel: SearchViewModelType, SearchViewModelInputs, SearchViewModelOutputs {
    let useCase: SearchUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var popluarPhotosObservable: Single<PopularPhotoList?> = {
        return self.popularPhotosSubject.take(1).asSingle()
    }()
    private let popularPhotosSubject: PublishRelay<PopularPhotoList?> = .init()
    
    init(useCase: SearchUseCaseInputPort,
         disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    
    func searchPhotos(query: String) {
        useCase.searchUseCase(query: query)
    }
    
    func fetchPopularPhotos(page: Int) {
        useCase.fetchPopularPhotos(page: page)
            .subscribe(onSuccess: { [weak self] photos in
                guard let self = self else {
                    return
                }
                
                self.popularPhotosSubject.accept(PopularPhotoList(photos: photos))
                },
                       onError: { error in
                        #if DEBUG
                        log.debug(error)
                        #endif
                        self.popularPhotosSubject.accept(nil)
            })
            .disposed(by: disposeBag)
    }
}
