//
//  WarpImageView.swift
//  WarpView
//
//  Created by Kota Kawanishi on 2019/08/25.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import SpriteKit

class WarpImageView: WarpView {
    
    init(image : UIImage) {
        let texture = SKTexture(image: image)
        let spriteNode = SKSpriteNode(texture: texture)
        super.init(spriteNode: spriteNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
