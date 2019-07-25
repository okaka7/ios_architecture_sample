//
//  PhotoCollectionDispatcher.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PhotoCollectionDispatcher {
    static let shared = PhotoCollectionDispatcher()
    
    let photoCollection = PublishRelay<[Int: [Int]?]>()
}
