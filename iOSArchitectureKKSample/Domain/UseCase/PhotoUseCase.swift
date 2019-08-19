//
//  PhotoUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol PhotoUseCaseInputPort: PhotoSelectable {
    func showDetail()
    func otherPhotosSlideUp()
}

protocol PhotoUseCaseOutputPort {
    func showDetail()
    func slideUp()
    func showShoto(_ photo: PhotoUIValueObject)
}
