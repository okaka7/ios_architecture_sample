//
//  CollectionPhotoViewCell.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import Nuke

class CollectionPhotoViewCell: UICollectionViewCell {
    
    lazy private(set) var overlapView: UIView = {
        let view: UIView = .init(frame: .zero)
        self.addSubview(view)
        self.bringSubviewToFront(view)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            .isActive = true
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            .isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor)
            .isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor)
            .isActive = true
        
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                overlapView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            } else {
                overlapView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        }
    }
    
    
    lazy private(set) var imageView: UIImageView = {
        let imageView: UIImageView = .init(frame: .zero)
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
        return imageView
    }()
    
    func configureImage(image: UIImage) {
        imageView.image = image
    }
    func configureImage(imageURL: URL) {
        Nuke.loadImage(with: imageURL, into: imageView)
        _ = overlapView
    }
    
    
}
