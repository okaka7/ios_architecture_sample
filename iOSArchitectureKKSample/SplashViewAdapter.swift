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
    func fetchCategoryImages()
}



protocol SplashControllerInjectable: class {
    func inject(controller: SplashViewInput)
}

final class SplashViewAdapter: SplashViewInput {
    
    
    var start: Date?
    
    private let useCase: PhotoPrepareUseCaseInputPort!
    let output: SplashViewModelProtocol
    
    init (useCase: PhotoPrepareUseCaseInputPort,
          output: SplashViewModelProtocol) {
        self.useCase = useCase
        self.output = output
        self.useCase.output = self
    }
    
    func fetchTopImages() {
        start = Date()
        useCase.fetchPopularPhotos(page: 1, photoEntities: [UnsplashPhotoEntity]())
    }
}
extension SplashViewAdapter: PhotoPrepareUseCaseOutputPort {
    func setTopImages(_ images: [UnsplashPhotoEntity]) {
        #if DEBUG
        log.debug("🖌yay")
        let elapsed = Date().timeIntervalSince(start!)
        print("時間は\(elapsed)")
        #endif
    }
    
    func fetchCategoryImages() {
        
    }
    
    func setCategoryImage(_ image: UnsplashPhotoEntity, category: Category) {
        print(image)
    }
}
