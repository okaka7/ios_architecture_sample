//
//  WarpView.swift
//  WarpView
//
//  Created by Kota Kawanishi on 2019/08/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import SpriteKit


enum WarpGripError: Error {
    case inappropriatePosition
}

typealias WarpGrid = SKWarpGeometryGrid

class WarpView: UIView {
    lazy private var skView: SKView = {
        let skView = SKView()
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        skView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        skView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        skView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        return skView
    }()
    
    lazy private var scene: SKScene = {
        let scene = SKScene(size: self.skView.frame.size)
        scene.backgroundColor = .clear
        return scene
    }()
    
    private var warpSpriteNode: SKSpriteNode
    
    
    init(spriteNode node: SKSpriteNode) {
        self.warpSpriteNode = node
        super.init(frame: .zero)
        scene.addChild(node)
        skView.presentScene(scene)
    }
    
    override func layoutSubviews() {
        warpSpriteNode.size = self.frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func warpAnimation(withDelay delay: TimeInterval = 0.0,
              warpGrids: [WarpGrid],
              timings: [TimeInterval],
              fadeOutDuration: TimeInterval,
              completion: @escaping () -> Void = {}) {
        
        guard let unwrappedWarp: SKAction = .animate(withWarps: warpGrids,
                                                     times: timings as [NSNumber]),
            let lastTime: TimeInterval = timings.last else {
            return
        }
        
        let warpSequence: SKAction = {
            let delayAction: SKAction = .wait(forDuration: delay)
            return SKAction.sequence([delayAction, unwrappedWarp])
        }()
        
        let fadeOutAction: SKAction = {
            let fadeOutDelay: SKAction = .wait(forDuration: lastTime - fadeOutDuration)
            let fadeOutAction: SKAction = .fadeOut(withDuration: fadeOutDuration)
            return SKAction.sequence([fadeOutDelay, fadeOutAction])
        }()
        
        let animationGroup: SKAction = .group([warpSequence, fadeOutAction])
        animationGroup.timingMode = .easeInEaseOut
        warpSpriteNode.run(animationGroup){
            completion()
        }
    }
    
    func warpTransitionAnimation(withDelay delay: TimeInterval = 0.0,
                                 fromWarpGrids: [WarpGrid],
                                 fromTimings: [TimeInterval],
                                 fadeOutDuration: TimeInterval,
                                 to toView: WarpView,
                                 transitionStartTime: TimeInterval,
                                 fadeInDuration: TimeInterval,
                                 toWarpGrids: [WarpGrid],
                                 toTimings: [TimeInterval],
                                 completion: @escaping () -> Void) {
        guard let unwrappedBackWarp: SKAction = .animate(withWarps: toWarpGrids,
                                                     times: toTimings as [NSNumber]) else {
                                                        return
        }
        let animationGroup: SKAction = {
            let waitAction: SKAction = .wait(forDuration: transitionStartTime)
            let fadeInAction = SKAction.fadeIn(withDuration: fadeInDuration)
            let group = SKAction.group([unwrappedBackWarp, fadeInAction])
            let sequenceAction = SKAction.sequence([waitAction, group])
            sequenceAction.timingMode = .easeInEaseOut
            return sequenceAction
        }()
        
        warpAnimation(withDelay: delay,
                      warpGrids: fromWarpGrids,
                      timings: fromTimings,
                      fadeOutDuration: fadeOutDuration)
        toView.warpSpriteNode.run( animationGroup, completion: {
            self.warpSpriteNode = toView.warpSpriteNode
            completion()
        })
    }
}
