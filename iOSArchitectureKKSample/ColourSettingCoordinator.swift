//
//  ColourSettingCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

final class ColourSettingCoordinator: Coordinator {
    let settingVC: ColourSettingViewController = {
        let settingVC: ColourSettingViewController = .init()
        settingVC.tabBarItem.badgeValue = R.string.localizable.setting()
        return settingVC
    }()
    
    func start() {
        return
    }
    
}
