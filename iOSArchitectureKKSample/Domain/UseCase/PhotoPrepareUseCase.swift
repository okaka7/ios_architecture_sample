//
//  PhotoFetchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol PhotoPrepareUseCaseInputPort: class {
    func fetchPopularPhotos() -> [PhotoObject]
    func searchPhotos(query: String) -> [PhotoObject]
}

protocol PhotoPrepareUseCaseOutputPort {
    func setTopImages(_ images: [PhotoObject])
    func setCategoryImage(_ image: [PhotoObject], category: Category)
}

final class PhotoPrepareUseCase: PhotoPrepareUseCaseInputPort {
    
    func fetchPopularPhotos() -> [PhotoObject] {
        <#code#>
    }
    
    func searchPhotos(query: String) -> [PhotoObject] {
        <#code#>
    }
    
    
}
