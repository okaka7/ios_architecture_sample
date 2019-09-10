//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashControllerProtocol: class {
    func fetchPopularPhotos(page: Int)
    func fetchAccount()
}

extension SplashControllerProtocol {
    func fetchPopularPhotos(page: Int = 1) {
        
    }
}

protocol SplashPresenterProtocol: class {
    var popularPhotosObservable: Observable<PopularPhotoList?> { get }
    var topPhotosObservable: Observable<TopPhotoList?> { get }
    var accountObservable: Observable<UnsplashAccountTarget.Response?> { get }
    
}

final class SplashViewAdapter: SplashControllerProtocol, SplashPresenterProtocol {
    private let useCase: PrepareAppUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var popularPhotosObservable: Observable<PopularPhotoList?> = {
        return self.popularPhotosSubject.asObservable()
    }()
    private let popularPhotosSubject: PublishRelay<PopularPhotoList?> = .init()
    
    lazy private(set) var topPhotosObservable: Observable<TopPhotoList?> = {
        return self.topPhotosSubject.asObservable()
    }()
    private let topPhotosSubject: PublishRelay<TopPhotoList?> = .init()

    private let accountSubject: PublishRelay<UnsplashAccountTarget.Response?> = .init()
    
    lazy private(set) var accountObservable: Observable<UnsplashAccountTarget.Response?> = {
        return self.accountSubject.asObservable()
    }()
    
    init (useCase: PrepareAppUseCaseInputPort,
          disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    
    func fetchPopularPhotos(page: Int = 1) {
        var popularPhotos: UnsplashPhotosTarget.Response = .init()
        var topPhotos: UnsplashPhotosTarget.Response = .init()
        useCase.fetchPopularPhotos(page: 1)
            .subscribe(onSuccess: { [weak self] photos in
                guard let self = self else {
                    return
                }
                popularPhotos.append(contentsOf: photos)
                let appendedTopPhotos: UnsplashPhotosTarget.Response = photos.filter { $0.isSuitableForTopImage }
                topPhotos.append(contentsOf: appendedTopPhotos)
                if topPhotos.count >= 20 {
                    self.topPhotosSubject.accept(TopPhotoList(photos: topPhotos))
                    self.popularPhotosSubject.accept(PopularPhotoList(photos: popularPhotos))
                } else {
                    self.fetchPopularPhotos(page: page + 1)
                }
            },
                       onError: { error in
                        #if DEBUG
                        log.debug(error)
                        #endif
                        self.topPhotosSubject.accept(nil)
                        self.popularPhotosSubject.accept(nil)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchAccount() {
        useCase.fetchAccount()
            .subscribe(onSuccess: { [weak self] account in
                    guard let self = self else {
                        return
                    }
                    self.accountSubject.accept(account)
                },
                       onError: { [weak self] error in
                        guard let self = self else {
                            return
                        }
                        #if DEBUG
                        log.debug(error)
                        #endif
                        self.accountSubject.accept(nil)
            })
            .disposed(by: disposeBag)
    }
}
