//
//  File.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

final class ColourCategoryCoordinator: Coordinator {
    
    lazy var naviVC: UINavigationController = {
        let naviVC: UINavigationController = .init(rootViewController: self.categoryVC)
        naviVC.navigationBar.barStyle = .black
        naviVC.navigationBar.isTranslucent = false
        naviVC.tabBarItem.title = R.string.localizable.home()
        return naviVC
    }()
    
    let categoryVC: HomeViewController = {
        let categoryVC: HomeViewController = .init()
        categoryVC.navigationItem.title = "Home"
        return categoryVC
    }()
    
    func start() {
        return
    }
    
}
