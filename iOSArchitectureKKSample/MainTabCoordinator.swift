//
//  MainTabCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    let mainTabBarController: UITabBarController = .init()
    let categoryCoordinator: ColourCategoryCoordinator = .init()
    let searchCoordinator: ColourSearchCoordinator = .init()
    let favoritesCoordinator: ColourFavoritesCoordinator = .init()
    let settingCoordinator: ColourSettingCoordinator = .init()
    
    init() {
        
    }
    
    func start() {
        return
    }
}
