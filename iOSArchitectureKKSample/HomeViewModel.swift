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
    func fetchTopPhotos(page: Int, photos: [PhotoUIOutputData])
    func selectPhoto(_ photo: PhotoUIOutputData)
    func switchPhoto(_ photo: PhotoUIOutputData)
}

protocol HomeViewModelOutputs: class {
    var topPhotosObservable: Observable<[SectionOfTopImage]> { get }
}

final class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
   
    let useCase: HomeUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var topPhotosObservable: Observable<[SectionOfTopImage]> = {
        return self.topPhotosSubject
            .take(1)
            .map {
                guard let photoList: [PhotoUIOutputData] = $0 else {
                    return [SectionOfTopImage(items: [])]
                }
                return [SectionOfTopImage(items: photoList)]
            }
            .asObservable()
    }()
    private let topPhotosSubject: PublishRelay<[PhotoUIOutputData]?> = .init()
    
    init(useCase: HomeUseCaseInputPort,
         disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    
    func selectPhoto(_ photo: PhotoUIOutputData) {
        
    }
    
    func switchPhoto(_ photo: PhotoUIOutputData) {
        
    }
    
    func fetchTopPhotos(page: Int = 1, photos: [PhotoUIOutputData] = []) {
        useCase.fetchTopPhotos(page: page)
            .retry(1)
            .map { $0.map {PhotoUIOutputData(photo: $0) }}
            .map { $0.filter{ $0.isSuitableForTopImage } }
            .subscribe(onSuccess: { [weak self] photoList in
                    let list: [PhotoUIOutputData] = photos + photoList
                    if list.count >= 12 {
                        self?.topPhotosSubject
                            .accept(Array(list.prefix(12)))
                    
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
