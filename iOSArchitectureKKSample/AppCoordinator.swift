//
//  AppCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

protocol TransitionToMainTabVC: class {
    func transitionToMainTab()
}

final class AppCoordinator: Coordinator, TransitionToMainTabVC {
    
    enum LaunchType {
        
    }
    
    private let window: UIWindow
    private lazy var rootViewController: SplashViewController = {
        return SplashViewController(transition: self)
    }()
    private var mainTabCoordinator: MainTabCoordinator
    
    init(window: UIWindow, mainTabCoordinator mainTab: MainTabCoordinator = MainTabCoordinator()) {
        self.window = window
        mainTabCoordinator = mainTab
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func transitionToMainTab() {
        self.mainTabCoordinator.start()
        self.rootViewController.present(self.mainTabCoordinator.mainTabBarController, animated: false)
    }
}
