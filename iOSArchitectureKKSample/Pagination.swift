//
//  Pagination.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/29.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

public struct Pagination {
    public var next: Int?
    public var last: Int?
    public var first: Int?
    public var prev: Int?
    
    public init(next: Int?, last: Int?, first: Int?, prev: Int?) {
        self.next = next
        self.last = last
        self.first = first
        self.prev = prev
    }
}
