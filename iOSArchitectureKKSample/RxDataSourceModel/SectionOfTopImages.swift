//
//  SectionOfTopImages.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/14.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import RxDataSources

struct SectionOfTopImage {
    var items: [Item]
}
extension SectionOfTopImage: SectionModelType {
    typealias Item = PhotoUIOutputData
    
    init(original: SectionOfTopImage, items: [Item]) {
        self = original
        self.items = items
    }
}
