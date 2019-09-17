//
//  UIImage+extesion.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
