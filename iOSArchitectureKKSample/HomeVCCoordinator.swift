//
//  File.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

protocol TransitionPreparationNotifiCation: class {
    var preparationObsevable: Observable<Void> { get }
}

protocol TransitionPreparationNotifiCationTransmitter: class {
    var notification: Observable<Void> { get }
}

final class HomeVCCoordinator: Coordinator, PreparationProtocol {
    
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
    
    func prepare() {
        self.homeVC.fetchTopPhotos()
    }
}

extension HomeVCCoordinator: TransitionPreparationNotifiCationTransmitter {
    var notification: Observable<Void> {
        return homeVC.preparationObsevable
    }
}
