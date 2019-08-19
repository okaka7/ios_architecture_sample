//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


protocol SplashController: class {
    
}



protocol SplashPresenterOutput: class {
    
}

protocol SplashControllerInjectable: class {
    func inject(controller: SplashController)
}


final class SplashViewAdapter: SplashController {
    let output: SplashPresenterOutput
    
    init (output: SplashPresenterOutput) {
        self.output = output
    }
}
