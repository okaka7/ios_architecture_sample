//
//  ColourSearchCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

final class SearchVCCoordinator: Coordinator {
    let searchVC: SearchViewController = {
        let searchVC: SearchViewController = .init()
        searchVC.tabBarItem.title = R.string.localizable.search()
        return searchVC
    }()
    func start() {
        
    }
}
