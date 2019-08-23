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
        naviVC.tabBarItem.title = R.string.localizable.category()
        return naviVC
    }()
    
    let categoryVC: HomeViewController = {
        let categoryVC: HomeViewController = .init()
        return categoryVC
    }()
    
    func start() {
        return
    }
    
}
