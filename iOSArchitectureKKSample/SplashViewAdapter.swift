//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol SplashControllerProtocol: class {
    func fetchPopularPhotos()
    func fetchCategoryImages()
    func fetchAccount()
}

protocol SplashPresenterProtocol: class {
}

final class SplashViewAdapter: SplashControllerProtocol, SplashPresenterProtocol {
    private let useCase: PrepareAppUseCaseInputPort
    let viewModel: SplashViewModelProtocol
    
    init (useCase: PrepareAppUseCaseInputPort,
          viewModel: SplashViewModelProtocol) {
        self.useCase = useCase
        self.viewModel = viewModel
    }
    
    func fetchPopularPhotos() {
        useCase.fetchPopularPhotos(page: 1, photoEntities: [UnsplashPhotoEntity]())
    }
    
    func fetchCategoryImages() {
        useCase.searchPhotos(query: Category.allCases, page: 1)
    }
    
    func fetchAccount() {
        
    }
}
