//
//  File.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

final class ColourCategoryCoordinator: Coordinator {
    let categoryVC: ColourCategoryViewController = {
        let categoryVC: ColourCategoryViewController = .init()
        categoryVC.tabBarItem.badgeValue = R.string.localizable.category()
        return categoryVC
    }()
    
    func start() {
        return
    }
    
}
