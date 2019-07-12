//
//  DribbbleState.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct DribbbleState: Codable, ExpressibleByStringLiteral, Equatable {
    typealias StringLiteralType = String
    
    let state: String
    
    init(stringLiteral value: DribbbleState.StringLiteralType) {
        self.state = value
    }
    
    static func ==(lhs: DribbbleState, rhs: DribbbleState) -> Bool {
        return lhs.state == rhs.state
    }
    
    static func ==(lhs: DribbbleState, rhs: String) -> Bool {
        return lhs.state == rhs
    }
}
