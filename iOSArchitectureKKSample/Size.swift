//
//  Size.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

extension Const {
    struct Size {
        struct Splash {
            static let iconSize: CGSize = CGSize(width: 66, height: 74.37)
            static let mainLabelfontSize: CGFloat = 60
            static let mainLabelSize: CGSize = {
                let iconSize: CGSize = Size.Splash.iconSize
                return CGSize(width: iconSize.width * 1.618, height: iconSize.height)
            }()
            static let marginBetweenIconAndMainLabel: CGFloat = 65
            static let subLabelfontSize: CGFloat = 19
            static let marginBetweenMainLabelAndSubLabel: CGFloat = 5
        }
    }
}
