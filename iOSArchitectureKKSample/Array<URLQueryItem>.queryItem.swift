//
//  Array<URLQueryItem>.queryItem.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

extension Array where Element == URLQueryItem {
    func getFirstQuery(_ key: String) -> URLQueryItem? {
        return self.first(where: { item in return item.name == key})
    }
    
    func getFirstQueryValue(_ key: String) -> Any? {
        guard let queryItem = self.first(where: { item in return item.name == key}) else {
            return nil
        }
        return queryItem.value
    }
}
