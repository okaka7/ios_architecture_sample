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

protocol SplashViewModelType: class {
    var inputs: SplashViewModelInputs { get }
    var outputs: SplashViewModelOutputs { get }
}

extension SplashViewModelType where Self: SplashViewModelInputs {
    var inputs: SplashViewModelInputs { return self }
}

extension SplashViewModelType where Self: SplashViewModelOutputs {
    var outputs: SplashViewModelOutputs { return self }
}

protocol SplashViewModelInputs: class {
    func prepareForMainTab()
    func transition()
}

protocol SplashViewModelOutputs: class {
    var transitionObservableRelay: Single<Void> { get }
}

final class SplashViewModel: SplashViewModelType,
                                SplashViewModelInputs,
SplashViewModelOutputs {
    private var readyForTransitonSubject: PublishRelay<Void> = .init()
    
    lazy private(set) var transitionObservableRelay: Single<Void> = {
        self.readyForTransitonSubject.take(1).asSingle()
    }()
    
    private let useCase: SplashUseCaseInputs
    private let disposeBag: DisposeBag = DisposeBag()
    let prepareForMainTabSubject: PublishRelay<Void> = .init()
    
    init(useCase: SplashUseCaseInputs) {
        self.useCase = useCase
    }
    
    func prepareForMainTab() {
        useCase.prepareForMainTab()
    }
    
    func transition() {
        useCase.transtion()
    }
}
