//
//  PhotoDetailUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol PhotoDetailUseCaseInputPort: PhotoLikeable, CollectionEditable, PhotoDownloadable {
    func showInfo()
}

protocol PhotoDetailUseCaseOutputPort: PhotoLikeUpdatale, UserTransitionable {
    func showInfo()
}
