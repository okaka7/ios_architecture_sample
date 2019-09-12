//
//  SplashViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

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
    
}

protocol SplashViewModelOutputs: class {
    
}

final class SplashViewModel: SplashViewModelType, SplashViewModelInputs, SplashViewModelOutputs {
    
    private let useCase: PrepareAppUseCaseInputPort
    
    init(useCase: PrepareAppUseCaseInputPort) {
        self.useCase = useCase
    }
}
