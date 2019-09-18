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
                let iconSize: CGSize = Splash.iconSize
                return CGSize(width: iconSize.width * 1.618, height: iconSize.height)
            }()
            static let marginBetweenIconAndMainLabel: CGFloat = 65
            static let subLabelfontSize: CGFloat = 19
            static let marginBetweenMainLabelAndSubLabel: CGFloat = 5
        }
        
        struct Home {
            static let photoCollectionHeight: CGFloat = 86.5
            static let photoCollectionInsets: UIEdgeInsets = UIEdgeInsets(top: 2,
                                                                          left: 2,
                                                                          bottom: 2,
                                                                          right: 2)
            private static let photoHeightRatioToWidth: CGFloat = 1.3
            static let photoCollectionItemSize: CGSize = {
                let insets: UIEdgeInsets = Home.photoCollectionInsets
                let height: CGFloat = Home.photoCollectionHeight - insets.top - insets.bottom
                let width: CGFloat = height / Home.photoHeightRatioToWidth
                return CGSize(width: width, height: height)
            }()
            static let photoCollectionItemLineSpace: CGFloat = 3.0
        }
    }
}
