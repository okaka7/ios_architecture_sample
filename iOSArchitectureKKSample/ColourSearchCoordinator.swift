//
//  ColourSearchCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

final class ColourSearchCoordinator: Coordinator {
    let searchVC: ColourSearchViewController = {
        let searchVC: ColourSearchViewController = .init()
        searchVC.tabBarItem.badgeValue = R.string.localizable.search()
        return searchVC
    }()
    func start() {
        
    }
}
