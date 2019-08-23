//
//  ColourSearchCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

final class SearchVCCoordinator: Coordinator {
    
    lazy var naviVC: UINavigationController = {
        let naviVC: UINavigationController = .init(rootViewController: self.searchVC)
        naviVC.navigationBar.barStyle = .black
        naviVC.navigationBar.isTranslucent = false
        naviVC.tabBarItem.title = R.string.localizable.search()
        return naviVC
    }()
    
    private let searchVC: SearchViewController = {
        let searchVC: SearchViewController = .init()
        searchVC.navigationItem.title = R.string.localizable.search()
        return searchVC
    }()
    func start() {
        
    }
}
