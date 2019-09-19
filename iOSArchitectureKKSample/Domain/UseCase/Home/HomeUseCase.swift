//
//  HomeUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeUseCaseInputPort: PhotoSelectable {
    func fetchTopPhotos(page: Int) -> Single<UnsplashPhotosTarget.Response>
    func downloadPhoto(id: String) -> Single<UnsplashDownloadPhotoTarget.Response>
    func showImages()
    func switchImage(id: String)
    func selectPhoto(_ photo: PhotoUIOutputData)
}

protocol HomeUseCaseOutputPort: PhotoTransitionable {
    func switchImage(_ image: PhotoObject)
    func showImages(_ image: [PhotoObject])
}

final class HomeUseCase: HomeUseCaseInputPort {
    private let photoRepository: PhotoRepository
    
    init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
       
    }
    
    func fetchTopPhotos(page: Int = 1) -> Single<UnsplashPhotosTarget.Response> {
        return photoRepository.fetchPhotos(page: page,
                                           perPage: 50,
                                           orderBy: .popular)
    }
    
    func downloadPhoto(id: String) -> Single<UnsplashDownloadPhotoTarget.Response> {
        return photoRepository.downloadPhotos(id: id)
    }
    
    func showImages() {
        
    }
    
    func switchImage(id: String) {
        
    }
    
    func selectPhoto(_ photo: PhotoUIOutputData) {
        
    }
    
    func selectImage(id: String) {
        
    }
}
