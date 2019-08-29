//
//  PhotoUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol PhotoUseCaseInputPort: PhotoSelectable, PhotoLikeable, CollectionEditable, PhotoDownloadable {
    func showDetail()
    func slideRelatedPhotosView(up: Bool)
}

protocol PhotoUseCaseOutputPort: PhotoLikeUpdatale, PhotoTransitionable, UserTransitionable {
    func showDetail()
    func slideRelatedPhotosView(up: Bool)
}
