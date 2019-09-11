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
    //func fetchPopularPhotos(page: Int)
    //func fetchAccount()
}

extension SplashControllerProtocol {
  
}

protocol SplashPresenterProtocol: class {
//    var popularPhotosObservable: Observable<PopularPhotoList?> { get }
//    var topPhotosObservable: Observable<TopPhotoList?> { get }
//    //var accountObservable: Observable<UnsplashAccountTarget.Response?> { get }
    
}

final class SplashViewAdapter: SplashControllerProtocol, SplashPresenterProtocol {
    private let useCase: PrepareAppUseCaseInputPort
    private let disposeBag: DisposeBag
    
    init (useCase: PrepareAppUseCaseInputPort,
          disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    

}
