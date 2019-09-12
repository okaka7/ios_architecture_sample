//
//  HomeViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

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
    
}

protocol HomeViewModelOutputs: class {
    
}

final class HomeViewModel {
    
}
