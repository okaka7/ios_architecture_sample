//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol SplashViewInputPort: class {
    func fetchTopImages()
    func fetchCategoryImages()
}

final class SplashController: SplashViewInputPort {
    func fetchCategoryImages() {
    }
    
    var start: Date?
    
    private let useCase: PhotoPrepareUseCaseInputPort!
    
    init (useCase: PhotoPrepareUseCaseInputPort) {
        self.useCase = useCase
    }
    
    func fetchTopImages() {
        useCase.fetchPopularPhotos(page: 1, photoEntities: [UnsplashPhotoEntity]())
    }
}

final class SplashViewPresenter: PhotoPrepareUseCaseOutputPort {
    let viewModel: SplashViewModelProtocol
    
    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
    }
    func setTopImages(_ images: [UnsplashPhotoEntity]) {
        
    }
    
    func setCategoryImage(_ image: UnsplashPhotoEntity, category: Category) {
        print(image)
    }
}
