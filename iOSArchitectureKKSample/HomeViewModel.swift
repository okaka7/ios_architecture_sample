//
//  HomeViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelType: class {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

extension HomeViewModelType where Self: HomeViewModelInputs {
    var inputs: HomeViewModelInputs { return self }
}

extension HomeViewModelType where Self: HomeViewModelOutputs {
    var outputs: HomeViewModelOutputs { return self }
}

protocol HomeViewModelInputs: class {
    func fetchTopPhotos(page: Int)
    func selectPhoto(_ photo: PhotoUIEntity)
    func switchPhoto(_ photo: PhotoUIEntity)
}

extension HomeViewModelInputs {
    func fetchTopPhotos(page: Int = 1) { }
}

protocol HomeViewModelOutputs: class {
    var topPhotosObservable: Single<PhotoUIList?> { get }
}

final class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    let useCase: HomeUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var topPhotosObservable: Single<PhotoUIList?> = {
        return self.topPhotosSubject.take(1).asSingle()
    }()
    private let topPhotosSubject: PublishRelay<PhotoUIList?> = .init()
    
    init(useCase: HomeUseCaseInputPort,
         disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    
    func selectPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func switchPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func fetchTopPhotos(page: Int = 1, photos: PhotoUIList = .init()) {
        useCase.fetchTopPhotos(page: page)
            .retry(1)
            .map(PhotoUIList.init(photoList: ))
            .map { $0.warpingPhotoFilter }
            .subscribe(onSuccess: { [weak self] photoList in
                    let list: PhotoUIList = photos + photoList
                    if list.count >= 20 {
                        self?.topPhotosSubject.accept(list)
                    } else {
                        self?.fetchTopPhotos(page: page + 1, photos: list)
                    }
                },
                       onError: { error in
                        #if DEBUG
                        log.debug(error)
                        #endif
                        self.topPhotosSubject.accept(nil)
            })
            .disposed(by: disposeBag)
    }
}
