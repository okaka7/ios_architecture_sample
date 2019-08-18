//
//  TokenRequestClient.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Result

protocol TokenRequestClient {
    func request(code: String,
                 onSuccess: (TokenValueObject) -> Void,
                 onError: (Swift.Error) -> Void)
}
