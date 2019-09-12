//
//  PhotoFetchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import DataCache

enum FetchTopImagesError: Error {
    case deficientPhotos
}

protocol SplashUseCaseType: class {
    var inputs: SplashUseCaseInputs { get }
    var outputs: SplashUseCaseOutputs { get }
}

extension SplashUseCaseType where Self: SplashUseCaseInputs {
    var inputs: SplashUseCaseInputs { return self }
}

extension SplashUseCaseType where Self: SplashUseCaseOutputs {
    var outputs: SplashUseCaseOutputs { return self }
}

protocol SplashUseCaseInputs: class {
    func prepareForMainTab()
    func transtion()
}

protocol SplashUseCaseOutputs: class {
    var readyForTransitonSingle: Single<Void> { get }
}

final class SplashUseCase: SplashUseCaseType, SplashUseCaseInputs, SplashUseCaseOutputs {
    lazy private(set) var readyForTransitonSingle: Single<Void> = {
        self.readyForTransitionRelay.take(1).asSingle()
    }()
    private let readyForTransitionRelay: PublishRelay<Void> = .init()
    
    var transitioner: SplashTransitioner!
    
    init() {
        
    }
    
    func prepareForMainTab() {
        transitioner.transition()
    }
    
    func prepareForMainTab() -> Single<Void> {
        return transitioner.transitionPreparationDoneObservable
    }
    
    func transtion() {
        transitioner.transition()
    }
}

extension SplashUseCase: SplashTransitionerInjectable {
    func inject(transitioner: SplashTransitioner) {
        self.transitioner = transitioner
    }
}
