//
//  SwiftyBeaver.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import SwiftyBeaver

#if DEBUG
let log: SwiftyBeaver.Type = {
    let log = SwiftyBeaver.self
    let console = ConsoleDestination()
    console.asynchronously = false
    let platform = SBPlatformDestination(
        appID: "dGP9zN",
        appSecret: "llk2d5Ykblm7256bcnixmq7wxtp3hs2y",
        encryptionKey: "cey6iswd7xM9rkv6bewttynpkhbtqXj2")
    
    log.addDestination(console)
    log.addDestination(platform)
    return log
}()
#endif
