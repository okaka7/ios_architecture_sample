//
//  SearchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

enum Category: Int {
    case animal
    case travel
    case fashion
}

protocol SearchUsecaseInputPort: PhotoSelectable {
    func openCategorySlide()
    func fetchCategoryPhotos()
    func searchPhotos(query: String)
}

protocol SearchUsecaseOutputPort {
    func setupCategoryPhotos(photos: [PhotoObject])
    func slideUpCategoryView()
    func showSearchResult(photos: [PhotoObject])
}

