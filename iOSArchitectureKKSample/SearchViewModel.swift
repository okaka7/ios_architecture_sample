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

protocol SearchViewModelOutputs: class {
    var popluarPhotosObservable: Single<PhotoUIList?> { get }
}

final class SearchViewModel: SearchViewModelType, SearchViewModelInputs, SearchViewModelOutputs {
    let useCase: SearchUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var popluarPhotosObservable: Single<PhotoUIList?> = {
        return self.popularPhotosSubject.take(1).asSingle()
    }()
    private let popularPhotosSubject: PublishRelay<PhotoUIList?> = .init()
    
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
            .retry(1)
            .map(PhotoUIList.init(photoList: ))
            .subscribe(onSuccess: { [weak self] photos in
                        self?.popularPhotosSubject.accept(photos)
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
