//
//  HomeTabDispatcher.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeTabDispatcher {
    static let shared = HomeTabDispatcher()
    
    let selectedItems = PublishRelay<[Int:Int]?>()
    let selectItem = PublishRelay<Int>()
    let downloadPhoto = PublishRelay<Int>()
}
