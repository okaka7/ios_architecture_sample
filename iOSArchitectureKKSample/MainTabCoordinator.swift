//
//  MainTabCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

final class MainTabCoordinator: Coordinator, PreparationProtocol {
    let mainTabBarController: UITabBarController = {
        let tab = UITabBarController()
        tab.tabBar.barStyle = .black
        tab.tabBar.isTranslucent = false
        return tab
    }()
    private let homeCoordinator: HomeVCCoordinator
    private let searchCoordinator: SearchVCCoordinator
    private let accountCoordinator: AccountVCCoordinator
    private let disposeBag: DisposeBag = .init()
    
    init(homeCoordinator: HomeVCCoordinator,
         searchCoordinator: SearchVCCoordinator,
         accountCoordinator: AccountVCCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.searchCoordinator = searchCoordinator
        self.accountCoordinator = accountCoordinator
        self.setupWaitForPreparationDone()
    }
    
    func prepare() {
        let preparations: [PreparationProtocol] = [self.homeCoordinator,
                                                   self.searchCoordinator,
                                                   self.accountCoordinator]
        preparations.forEach {
            $0.prepare()
        }
    }
    
    func start() {
        let tabBarControllers: [UIViewController] = [ homeCoordinator.naviVC,
            searchCoordinator.naviVC,
            accountCoordinator.naviVC]
        
        mainTabBarController.setViewControllers( tabBarControllers, animated: false)
        
        return
    }
    
    func setupWaitForPreparationDone() {
        Observable
            .merge([self.homeCoordinator.notification,
                    self.searchCoordinator.notification,
                    self.accountCoordinator.notification])
            .subscribe(onCompleted: {
                NotificationCenter.default.post(name: .transitionToMainTab, object: nil)
            })
            .disposed(by: disposeBag)
       
    }
}
