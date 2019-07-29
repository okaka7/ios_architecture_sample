//
//  HomeVCDispatcher.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PhotoDispatcher {
    static let shared = PhotoDispatcher()
    
    let photos = PublishRelay<[Int]>()
    let reloadPhoto = PublishRelay<Void>()
}
