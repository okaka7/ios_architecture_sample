//
//  File.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

final class HomeVCCoordinator: Coordinator {
    lazy var naviVC: UINavigationController = {
        let naviVC: UINavigationController = .init(rootViewController: self.homeVC)
        naviVC.navigationBar.barStyle = .black
        naviVC.navigationBar.isTranslucent = false
        naviVC.tabBarItem.title = R.string.localizable.home()
        return naviVC
    }()
    
    private let homeVC: HomeViewController
    
    init(homeVC: HomeViewController) {
        homeVC.navigationItem.title = "Home"
        self.homeVC = homeVC
    }
    
    func start() {
        return
    }
}
