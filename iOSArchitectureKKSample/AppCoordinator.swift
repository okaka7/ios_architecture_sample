//
//  AppCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    enum LaunchType {
        
    }
    
    private let window: UIWindow
    private let rootViewController: SplashViewController
    private var mainTabCoordinator: MainTabCoordinator
    
    init(window: UIWindow, mainTabCoordinator mainTab: MainTabCoordinator = MainTabCoordinator()) {
        self.window = window
        rootViewController = .init()
        mainTabCoordinator = mainTab
        
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
