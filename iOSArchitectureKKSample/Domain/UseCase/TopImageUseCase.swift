//
//  HomeUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


protocol TopImageUseCaseInputPort: PhotoSelectable {
    func showImages()
    func switchImage(id: String)
}

protocol TopImageUseCaseOutputPort {
    func showUnage(_ image: PhotoUIValueObject)
    func switchImage(_ image: PhotoUIValueObject)
}


