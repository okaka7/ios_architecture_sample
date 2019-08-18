//
//  Builder.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import UIKit


final class Builder {
    static func buildAppCoordinator(window: UIWindow) -> AppCoordinator {
        let vc: SplashViewController = .init()
        let presenter: SplashPresenterProtocol = SplashPresenter.init(output: vc)
        vc.inject(presenter: presenter)
        
        let coordinator: AppCoordinator = .init(window: window,
                                                rootVC: vc)
        vc.inject(transitioner: coordinator)
        
        return  coordinator
    }
}
