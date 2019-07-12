//
//  DribbbleState.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

struct DribbbleState: ExpressibleByStringLiteral, Equatable, Codable, CustomStringConvertible, CustomDebugStringConvertible  {
    
    typealias StringLiteralType = String
    
    let state: String
    
    var description: String { return state }
    
    var debugDescription: String { return "\(String(describing: type(of: self))) \(state)"}
    
    
    init(stringLiteral value: StringLiteralType) {
        self.state = value
    }
    
    static func == (lhs: DribbbleState, rhs: DribbbleState) -> Bool {
        return lhs.state == rhs.state
    }
    
    static func == (lhs: DribbbleState, rhs: String) -> Bool {
        return lhs.state == rhs
    }
}
