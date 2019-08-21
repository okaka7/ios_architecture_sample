//
//  CollectionEditable.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol CollectionEditable {
    func addPhoto(id: String, into collectionID: String)
    func removePhoto(id: String, from collectionID: String)
    
}
