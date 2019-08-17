//
//  PhotoUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol PhotoUseCaseInputPort {
    func showDetail()
    func otherPhotosSlideUp()
    func selectPhoto(id: String)
}
