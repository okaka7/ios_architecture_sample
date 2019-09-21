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

class WarpView: UIView {
    lazy private var skView: SKView = {
        let skView = SKView(frame: .zero)
        skView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(skView)
        skView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        skView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        skView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        skView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        return skView
    }()
    
    private var warpSpriteNode: SKSpriteNode
    
    
    init(spriteNode node: SKSpriteNode) {
        self.warpSpriteNode = node
        super.init(frame: .zero)
    }
    
    lazy var scene: SKScene = {
        let scene: SKScene = .init(size: self.frame.size)
        scene.backgroundColor = .clear
        
        return scene
    }()
    
 
    override func updateConstraints() {
        super.updateConstraints()
        _ = skView
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        warpSpriteNode.size = self.frame.size
        warpSpriteNode.position = CGPoint(x:scene.frame.midX, y:scene.frame.midY)
        scene.addChild(self.warpSpriteNode)
        skView.presentScene(scene)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func warpAnimation(withDelay delay: TimeInterval = 0.0,
              warpings: [Warping],
              fadeOutDuration: TimeInterval,
              completion: @escaping () -> Void = {}) {

        guard let firstWarp: Warping = warpings.first else {
                return
        }
        let lastTime: TimeInterval = warpings.reduce(delay) {(result, warping) in result + warping.duration }
        
         warpSpriteNode.warpGeometry = firstWarp.sourceGrid
         
         let grupe: SKAction = {
             let fadeOutDelay: SKAction = .wait(forDuration: lastTime - fadeOutDuration)
             let fadeOutAction: SKAction = .fadeOut(withDuration: fadeOutDuration)
             fadeOutAction.timingMode = .easeInEaseOut
             let sequence: SKAction = SKAction.sequence([fadeOutDelay, fadeOutAction])
             let warpAction: SKAction = {
                 let warpActions: [SKAction] = warpings.map {$0.warpAction}
                 let warpSequenceAction: SKAction = .sequence(warpActions)
                 warpSequenceAction.timingMode = .easeInEaseOut
                 return warpSequenceAction
             }()
             let groupe = SKAction.group([warpAction, sequence])
             return groupe
         }()
        
        self.warpSpriteNode.run(grupe) {
            completion()
        }
    }
    
    func warpTransitionAnimation(withDelay delay: TimeInterval = 0.0,
                                 fromWarpings: [Warping],
                                 fadeOutDuration: TimeInterval,
                                 to toView: UIImage,
                                 transitionStartTime: TimeInterval,
                                 fadeInDuration: TimeInterval,
                                 toWarpings: [Warping],
                                 completion: @escaping () -> Void = {}) {
        guard let _ = fromWarpings.first,
            let toFirst: Warping = toWarpings.first else {
                return
        }
        
        let actionBack: SKAction = {
            let waitAction = SKAction.wait(forDuration: transitionStartTime)
            let fadeInAction = SKAction.fadeIn(withDuration: fadeInDuration)
            fadeInAction.timingMode = .easeInEaseOut
            let warpAction: SKAction = {
                let warpActions: [SKAction] = toWarpings.map {$0.warpBackAction}
                let warpSequenceAction: SKAction = .sequence(warpActions)
                warpSequenceAction.timingMode = .easeInEaseOut
                return warpSequenceAction
            }()
            let group = SKAction.group([warpAction, fadeInAction])
            let sequenceActionBack = SKAction.sequence([waitAction, group])
            return sequenceActionBack
        }()
        
        let toSprite: SKSpriteNode = {
                        let texture: SKTexture = SKTexture(image: toView)
                        let sprite: SKSpriteNode = SKSpriteNode(texture: texture)
                        sprite.position = CGPoint(x:scene.frame.midX, y:scene.frame.midY)
                        sprite.size = scene.size
                        sprite.alpha = 0.0
                        sprite.warpGeometry = toFirst.backSourceGrid
                        return sprite
                    }()
        
        scene.addChild(toSprite)
        let fromLastTime: TimeInterval = fromWarpings.reduce(delay) {(result, warping) in result + warping.duration }
        let toLastTime: TimeInterval = toWarpings.reduce(transitionStartTime) {(result, warping) in result + warping.duration }
        let completion: ()->() = {
            self.warpSpriteNode.removeFromParent()
            self.warpSpriteNode = toSprite
            completion()
        }
        if fromLastTime < toLastTime {
            warpAnimation(withDelay: delay,
                          warpings: fromWarpings,
                          fadeOutDuration: fadeOutDuration)
            toSprite.run(actionBack) {
                completion()
            }
        } else {
            warpAnimation(withDelay: delay,
                          warpings: fromWarpings,
                          fadeOutDuration: fadeOutDuration,
                          completion:{completion()})
            toSprite.run(actionBack)
        }
        
    }
}
