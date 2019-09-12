//
//  AppCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/13.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SplashTransitioner: class {
    func transition()
    var transitionPreparationDoneObservable: Single<Void> { get }
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
    private let readyForTransitionRelaySubject: PublishRelay<Void> = .init()
    
    var transitionPreparationDoneObservable: Single<Void> {
        return readyForTransitionRelaySubject.take(1).asSingle()
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
