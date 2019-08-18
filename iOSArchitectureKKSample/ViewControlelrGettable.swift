//
//  ViewControlelrGettable.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

protocol TopViewContollerGettable {
    var topViewController: UIViewController? { get }
}

extension TopViewContollerGettable {
    var topViewController: UIViewController? {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            var vc: UIViewController = rootViewController
            
            while let nextVC = vc.extension.showedViewController {
                vc = nextVC
            }
            
            return vc
        } else {
            return nil
        }
    }
}

