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
    var start: Date?
    
    private let useCase: PhotoPrepareUseCaseInputPort!
    let output: SplashViewPresenter
    
    init (useCase: PhotoPrepareUseCaseInputPort,
          output: SplashViewPresenter) {
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
    
    func setCategoryImage(_ image: UnsplashPhotoEntity, category: Category) {
        print(image)
    }
}
