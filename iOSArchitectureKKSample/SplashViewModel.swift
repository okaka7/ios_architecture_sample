//
//  SplashViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashViewModelProtocol: class {
    func setTopImages(_ images: [UnsplashPhotoEntity])
}

final class SplashViewModel: SplashViewModelProtocol {
    private let presenter: SplashPresenterProtocol
    
    init(presenter: SplashPresenterProtocol) {
        self.presenter = presenter
    }
    private let topImagesSubject = PublishRelay<[UnsplashPhotoEntity]>()
    
    lazy var setTopImages: Observable<[UnsplashPhotoEntity]> = {
        return topImagesSubject.asObservable()
    }()
    
    func setTopImages(_ images: [UnsplashPhotoEntity]) {
        topImagesSubject.accept(images)
    }
}
