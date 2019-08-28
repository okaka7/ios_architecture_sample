//
//  SearchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    case people
    case travel
    case animal
    case fashion
    case nature
    case architecture
}

protocol SearchUseCaseInputPort: PhotoSelectable {
    func slideCategoryView(up: Bool)
    func fetchCategoryPhotos()
    func searchUseCase(query: String)
    func selectPhoto(photo: PhotoUIEntity)
}

protocol SearchUsecaseOutputPort: PhotoTransitionable {
    func setupCategoryPhotos(photos: [PhotoObject])
    func slideCategoryView(up: Bool)
    func showSearchResult(photos: [PhotoObject])
}
