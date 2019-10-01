//
//  PhotoLoadable.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import Nuke

protocol PhotoImageLoadable {
    func loadPhotoImage(imageURL: URL) -> Single<ImageResponse>
}