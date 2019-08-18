//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


protocol SplashPresenterProtocol: class {
    
}

protocol SplashPresenterOutput: class {
    
}


final class SplashPresenter: SplashPresenterProtocol {
    let output: SplashPresenterOutput
    
    init (output: SplashPresenterOutput) {
        self.output = output
    }
}
