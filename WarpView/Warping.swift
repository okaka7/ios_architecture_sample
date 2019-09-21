//
//  Warping.swift
//  WarpAnimation
//
//  Created by Kota Kawanishi on 2019/09/22.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import SpriteKit

public struct Warping {
    let rows: Int
    let columns: Int
    let fromPositions: [SIMD2<Float>]
    let toPositions: [SIMD2<Float>]
    let duration: TimeInterval
    
    init(colums: Int, rows: Int,
         fromPositions from: [CGPoint], toPositions to: [CGPoint],
         duration: TimeInterval) {
        let num: Int = (rows + 1) * (colums + 1)
        guard from.count == num,
            to.count == num else {
                fatalError("positions number is not correponded with row and line")
        }
        
        self.rows = rows
        self.columns = colums
        self.fromPositions = from.map { SIMD2<Float>(x: Float($0.x), y: Float($0.y)) }
        self.toPositions = to.map { SIMD2<Float>(x: Float($0.x), y: Float($0.y)) }
        self.duration = duration
    }
    
    internal var sourceGrid: SKWarpGeometryGrid {
        return SKWarpGeometryGrid(columns: columns,
                                  rows: rows,
                                  sourcePositions: fromPositions,
                                  destinationPositions: fromPositions)
    }
    
    internal var backSourceGrid: SKWarpGeometryGrid {
        let sourcePosition: [SIMD2<Float>] = {
            var source: [SIMD2<Float>] = []
            for line in stride(from: Float(columns), through: 0, by: -1) {
                for row in stride(from: 0.0 as Float, through: Float(rows), by: 1) {
                    let x: Float = row / 10
                    let y: Float = line / 10
                    source.append(SIMD2<Float>(x: x, y: y))
                }
            }
            return source
        }()
        return SKWarpGeometryGrid(columns: columns,
                                  rows: rows,
                                  sourcePositions: sourcePosition,
                                  destinationPositions: fromPositions)
    }
    
    internal var warpGrid: SKWarpGeometryGrid {
        return SKWarpGeometryGrid(columns: columns,
                                  rows: rows,
                                  sourcePositions: fromPositions,
                                  destinationPositions: toPositions)
    }
    
    internal var warpBackGrid: SKWarpGeometryGrid {
        return SKWarpGeometryGrid(columns: columns,
                                  rows: rows,
                                  sourcePositions: toPositions,
                                  destinationPositions: toPositions)
    }
    
    internal var warpAction: SKAction {
        return SKAction.warp(to: warpGrid, duration: self.duration)!
    }
    
    internal var warpBackAction: SKAction {
        return SKAction.warp(to: warpBackGrid, duration: self.duration)!
    }
    
}
