//
//  KeychainStore+Rx.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/21.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import RxSwift

extension KeychainStore: ReactiveCompatible { }

public extension Reactive where Base: KeychainStore {
    
}
