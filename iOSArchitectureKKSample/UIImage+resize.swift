//
//  UIImage+resize.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

extension UIImage: ExtensionCompatible {}

extension Extension where Base: UIImage {
    func resize(size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / base.size.width
        let heightRatio = _size.height / base.size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let resizedSize = CGSize(width: base.size.width * ratio,
                                 height: base.size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        base.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    // scale the image at rates
    func scaleImage(scaleSize:CGFloat) -> UIImage? {
        let reSize = CGSize(width: base.size.width * scaleSize, height: base.size.height * scaleSize)
        return base.extension.resize(size: reSize)
    }
}
