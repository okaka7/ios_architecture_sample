//
//  SplashViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashViewModelProtocol: class {
    var prepareObservable: Observable<Any> { get }
}

final class SplashViewModel: SplashViewModelProtocol {
    private let presenter: SplashPresenterProtocol
    
    lazy var prepareObservable: Observable<Any> = {
        return Observable.merge(self.presenter.accountObservable.map { $0 as Any},
                                self.presenter.popularPhotosObservable.map { $0 as Any},
                                self.presenter.topPhotosObservable.map { $0 as Any})
    }()
    
    init(presenter: SplashPresenterProtocol) {
        self.presenter = presenter
    }
}
