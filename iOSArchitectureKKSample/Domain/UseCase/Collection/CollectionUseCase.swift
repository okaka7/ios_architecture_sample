//
//  CollectionUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol CollectionUseCaseInputPort: PhotoSelectable, CollectionSelectable {
    func showCollectionPhotos(id: String)
    func showRelatedCollections(id: String)
}

protocol CollectionUseCaseOutputPort: PhotoTransitionable, CollectionTransitionable {
}
