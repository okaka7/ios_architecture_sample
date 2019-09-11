//
//  SearchViewAdapter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol SearchViewInputPort: class {
    func fetchPopularPhotos()
    func searchPhotos(query: String)
}

final class SearchController: SearchViewInputPort {

    let useCase: SearchUseCaseInputPort
    
    init(useCase: SearchUseCaseInputPort) {
        self.useCase = useCase
    }
    
    func searchPhotos(query: String) {
        useCase.searchUseCase(query: query)
    }
    
    func fetchPopularPhotos() {
        <#code#>
    }
}
