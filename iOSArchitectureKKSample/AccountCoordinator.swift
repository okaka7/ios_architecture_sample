//
//  ColourSettingCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

final class AccountCoordinator: Coordinator {
    lazy var naviVC: UINavigationController = {
        let naviVC: UINavigationController = .init(rootViewController: self.accountVC)
        naviVC.navigationBar.barStyle = .black
        naviVC.navigationBar.isTranslucent = false
        naviVC.tabBarItem.title = R.string.localizable.account()
        return naviVC
    }()
    
    private let accountVC: AccountViewController = {
        let settingVC: AccountViewController = .init()
        settingVC.navigationItem.title = R.string.localizable.account()
        return settingVC
    }()
    
    func start() {
        return
    }
    
}
