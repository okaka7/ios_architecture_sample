//
//  CollectionPhotoViewCell.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

class CollectionPhotoViewCell: UICollectionViewCell {
    var image: UIImage?
    
    func configureImage(image: UIImage) {
        self.image = image
        
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            .isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            .isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor)
            .isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
            .isActive = true
    }
}
