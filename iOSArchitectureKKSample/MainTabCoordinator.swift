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
    private let accountCoordinator: AccountVCCoordinator
    
    init(homeCoordinator: HomeVCCoordinator,
         searchCoordinator: SearchVCCoordinator,
         accountCoordinator: AccountVCCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.searchCoordinator = searchCoordinator
        self.accountCoordinator = accountCoordinator
    }
    
    func prepare() {
        
    }
    
    func start() {
        let tabBarControllers: [UIViewController] = [ homeCoordinator.naviVC,
            searchCoordinator.naviVC,
            accountCoordinator.naviVC]
        
        mainTabBarController.setViewControllers( tabBarControllers, animated: false)
        
        return
    }
}
