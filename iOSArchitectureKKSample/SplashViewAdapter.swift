//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


protocol SplashViewInput: class {
    
}

protocol SplashViewPresenter: class {
    
}

protocol SplashControllerInjectable: class {
    func inject(controller: SplashViewInput)
}


final class SplashViewAdapter: SplashViewInput {
    let output: SplashViewPresenter
    
    init (output: SplashViewPresenter) {
        self.output = output
    }
}
