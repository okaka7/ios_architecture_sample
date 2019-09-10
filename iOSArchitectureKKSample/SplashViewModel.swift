//
//  SplashViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

protocol SplashViewModelProtocol: class {
    var prepareObservable: Observable<Any> { get }
}

final class SplashViewModel: SplashViewModelProtocol {
    let prepareObservable: Observable<Any>
    
    init(presenter: SplashPresenterProtocol) {
        self.prepareObservable = Observable.merge(presenter.accountObservable.map { $0 as Any },
                                                  presenter.popularPhotosObservable.map { $0 as Any },
                                                  presenter.topPhotosObservable.map { $0 as Any })
    }
}
