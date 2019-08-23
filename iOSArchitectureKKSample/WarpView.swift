//
//  WarpView.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import SpriteKit

class WarpView: UIView {
    lazy var skView: SKView = {
        let skView = SKView()
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        skView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        skView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        skView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        return skView
    }()
    
    lazy var scene: SKScene = {
        let scene = SKScene(size: self.skView.frame.size)
        return scene
    }()
    

}
