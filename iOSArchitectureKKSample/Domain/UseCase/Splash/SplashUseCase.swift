//
//  PhotoFetchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import DataCache

enum FetchTopImagesError: Error {
    case deficientPhotos
}

protocol PrepareAppUseCaseInputPort: class {
    func prepareForMainTab()
    func prepareForMainTab() -> Observable<Void>
    func transtion()
}

protocol PhotoPrepareUseCaseOutputPort: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
    func setCategoryImage(_ image: [Category : UnsplashPhotoEntity])
}

final class SplashUseCase: PrepareAppUseCaseInputPort {
    
    var transitioner: SplashTransitioner!
    
    func prepareForMainTab() {
        
    }
    
    func prepareForMainTab() -> Observable<Void> {
        return transitioner.transitionPreparationObservable
    }
    
    func transtion() {
        transitioner.transition()
    }
}

extension SplashUseCase: SplashTransitionerInjectable {
    func inject(transitioner: SplashTransitioner) {
        self.transitioner = transitioner
    }
}
