//
//  AppCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

protocol SplashTransitioner: class {
    func transition()
    var transitionPreparationObservable: Observable<Void> { get }
}

protocol SplashTransitionerInjectable: class {
    func inject(transitioner: SplashTransitioner)
}

final class AppCoordinator: Coordinator, SplashTransitioner {
    enum LaunchType {
        
    }
    
    private let window: UIWindow
    private let rootViewController: SplashViewController
    private var mainTabCoordinator: MainTabCoordinator
    
    var transitionPreparationObservable: Observable<Void> {
        return Observable.just(Void())
    }
 
    init(window: UIWindow,
         rootVC: SplashViewController,
         mainTabCoordinator mainTab: MainTabCoordinator
        ) {
        self.window = window
        self.rootViewController = rootVC
        self.mainTabCoordinator = mainTab
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        //rootViewController.fetchTopImage()
    }
    
    func prepareForMainTabCoordination() {
        
    }
    
    func transition() {
        self.mainTabCoordinator.start()
        self.rootViewController
            .present(self.mainTabCoordinator.mainTabBarController,
                    animated: false)
    }
}
