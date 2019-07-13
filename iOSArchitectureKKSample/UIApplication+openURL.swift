//
//  UIApplication+openURL.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/12.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

public extension UIApplication {
    @discardableResult
    func openURLIfPossible(_ url: URL,
                           options: [UIApplication.OpenExternalURLOptionsKey: Any],
                           completionHandler: ((Bool) -> Void)? = nil) -> Bool {
        if self.canOpenURL(url) {
            self.open(url, options: options, completionHandler: completionHandler)
            return true
        }
        return false
    }
}
