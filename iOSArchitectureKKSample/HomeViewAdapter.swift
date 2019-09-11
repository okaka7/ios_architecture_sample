//
//  HomeViewAdapter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/20.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

protocol HomeViewInputPort: class {
    func fetchTopPhotos(page: Int)
    func selectPhoto(_ photo: PhotoUIEntity)
    func switchPhoto(_ photo: PhotoUIEntity)
}

extension HomeViewInputPort {
    func fetchTopPhotos(page: Int = 1) { }
}

final class HomeViewAdapter: HomeViewInputPort {
    let useCase: HomeUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var topPhotosObservable: Observable<TopPhotoList?> = {
        return self.topPhotosSubject.asObservable()
    }()
    private let topPhotosSubject: PublishRelay<TopPhotoList?> = .init()
    
    init(useCase: HomeUseCaseInputPort,
         disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    
    func selectPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func switchPhoto(_ photo: PhotoUIEntity) {
        
    }
    
    func fetchTopPhotos(page: Int = 1) {
        var topPhotos: UnsplashPhotosTarget.Response = .init()
        useCase.fetchTopPhotos(page: page)
            .subscribe(onSuccess: { [weak self] photos in
                guard let self = self else {
                    return
                }
                let appendedPhotos: UnsplashPhotosTarget.Response = photos.filter { $0.isSuitableForTopImage }
                topPhotos.append(contentsOf: appendedPhotos)
                if topPhotos.count >= 20 {
                    self.topPhotosSubject.accept(TopPhotoList(photos: topPhotos))
                } else {
                    self.fetchTopPhotos(page: page + 1)
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
