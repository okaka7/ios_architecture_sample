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

protocol SearchUsecaseInputPort {
    func openCategorySlide()
    func searchPhotos(query: String)
    func selectPhoto(id: String)
}
