//
//  MainTabCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    let mainTabBarController: UITabBarController = {
        let tab = UITabBarController()
        tab.tabBar.isTranslucent = false
        return tab
    }()
    private let homeCoordinator: HomeVCCoordinator
    private let searchCoordinator: SearchVCCoordinator
    private let settingCoordinator: AccountCoordinator = .init()
    
    init(homeCoordinator: HomeVCCoordinator,
         searchCoordinator: SearchVCCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.searchCoordinator = searchCoordinator
    }
    
    func start() {
        let tabBarControllers: [UIViewController] = [ homeCoordinator.naviVC,
            searchCoordinator.naviVC,
            settingCoordinator.naviVC]
        
        mainTabBarController.setViewControllers( tabBarControllers, animated: false)
        
        return
    }
}
