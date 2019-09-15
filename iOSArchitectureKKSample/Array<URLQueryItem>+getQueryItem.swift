//
//  Array<URLQueryItem>.queryItem.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

extension Array where Element == URLQueryItem {
    // Note: return the query Item of which name property is equal with key string in Array<URLQueryItem>
    //Note: Array<URLQueryItem>の配列内にある引数keyと同等のnameを保持しているURLQueryItemを返す。(該当するものがなければnilを返す)
    func getFirstQuery(_ key: String) -> URLQueryItem? {
        return self.first(where: { item in return item.name == key})
    }
    // Note: return the value of query Item of which name property is equal with key string in Array<URLQueryItem>
    //Note: Array<URLQueryItem>の配列内にある引数keyと同等のnameを保持しているURLQueryItemのvalueを返す。(該当するものがなければnilを返す)
    func getQueryValue(_ key: String) -> Any? {
        guard let queryItem = self.first(where: { item in return item.name == key}) else {
            return nil
        }
        return queryItem.value
    }
}
