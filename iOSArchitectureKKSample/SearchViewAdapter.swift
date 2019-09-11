//
//  SearchViewAdapter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewInputPort: class {
    func fetchPopularPhotos(page: Int)
    func searchPhotos(query: String)
}

extension SearchViewInputPort {
    func fetchPopularPhotos(page: Int = 1) { }
}

final class SearchViewAdapter: SearchViewInputPort {
    let useCase: SearchUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var popularPhotosObservable: Observable<PopularPhotoList?> = {
        return self.popularPhotosSubject.asObservable()
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
