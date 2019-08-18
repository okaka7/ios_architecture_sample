//
//  HomeUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


protocol TopImageUseCaseInputPort {
    func switchTopImage(id: String)
    func selectTopImage(id: String)
}

protocol TopImageUseCaseOutputPort {
    
}
