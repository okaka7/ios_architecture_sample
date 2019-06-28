//
//  ColourFavoritesCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

final class ColourFavoritesCoordinator: Coordinator {
    let favoritesVC: ColourFavoritesViewController = {
        let favoritesVC: ColourFavoritesViewController = .init()
        favoritesVC.tabBarItem.title = R.string.localizable.favorites()
        return favoritesVC
    }()
    func start() {
        return
    }    
}
