//
//  Extension.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol ExtensionCompatible {
    associatedtype ExtensionCompatibleType
    static var `extension`: Extension<ExtensionCompatibleType>.Type { get }
    var `extension`: Extension<ExtensionCompatibleType> { get }
}

extension ExtensionCompatible {
    static var `extension`: Extension<Self>.Type {
        return  Extension<Self>.self
    }
    
    var `extension`: Extension<Self> {
        return Extension<Self>(base: self)
    }
}

struct Extension<Base> {
    let base: Base
}
