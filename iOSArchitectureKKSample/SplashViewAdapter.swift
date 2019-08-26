//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


protocol SplashViewInput: class {
    func fetchTopImages()
}

protocol SplashViewPresenter: class {
    
}

protocol SplashControllerInjectable: class {
    func inject(controller: SplashViewInput)
}

final class SplashViewAdapter: SplashViewInput {
    
    private let useCase: PhotoPrepareUseCaseInputPort!
    let output: SplashViewPresenter
    
    init (useCase: PhotoPrepareUseCaseInputPort,
          output: SplashViewPresenter) {
        self.useCase = useCase
        self.output = output
        self.useCase.output = self
    }
    
    func fetchTopImages() {
        useCase.fetchPopularPhotos(page: 1, photoEntities: [UnsplashPhotoEntity]())
    }
}


extension SplashViewAdapter: PhotoPrepareUseCaseOutputPort {
    func setTopImages(_ images: [UnsplashPhotoEntity]) {
        print(images)
    }
    
    func setCategoryImage(_ image: UnsplashPhotoEntity, category: Category) {
        print(image)
    }
}
