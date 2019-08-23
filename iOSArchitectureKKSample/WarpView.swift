//
//  WarpView.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import SpriteKit

protocol Warp {
    func warp()
}

protocol WarpTransition {
    func warpTransiton(to node: SKSpriteNode)
}

class WarpView: UIView, Warp {
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
    
    var warpSpriteNode: SKSpriteNode
    
    init(warpSpriteNode sprite: SKSpriteNode) {
        warpSpriteNode = sprite
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func warp() {
        fatalError("this is abstract method")
    }
}

class WarpTransitionView: WarpView, WarpTransition {
    
    func warpTransiton(to node: SKSpriteNode) {
        
    }
}
