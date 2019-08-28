//
//  HomeUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol HomeUseCaseInputPort: PhotoSelectable {
    func showImages()
    func switchImage(id: String)
}

protocol HomeUseCaseOutputPort: PhotoTransitionable {
    func switchImage(_ image: PhotoObject)
    func showImages(_ image: [PhotoObject])
}
