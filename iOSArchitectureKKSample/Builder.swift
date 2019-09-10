//
//  Builder.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import UIKit
import DataCache

final class Builder {
    static func buildAppCoordinator(window: UIWindow) -> AppCoordinator {
        let webAPIClient: UnsplashAPIProvider = .shared
        let repository: FetchPhotoGateWay = .init(client: webAPIClient)
        let localCache: LocalCache = .init()
        let useCase: AppPrepareUseCase = .init(repository: repository,
                                               cache: localCache)
        let viewAdapter: SplashViewAdapter = .init(useCase: useCase)
        let viewModel: SplashViewModel = .init(presenter: viewAdapter)
        let vc: SplashViewController = .init(controller: viewAdapter,
                                             viewModel: viewModel)
        
        let coordinator: AppCoordinator = .init(window: window,
                                                rootVC: vc)
        vc.inject(transitioner: coordinator)
        
        return  coordinator
    }
    
    static func buildMainTabCoordinator() -> MainTabCoordinator {
        return MainTabCoordinator()
    }
    
    static func buildHomeVCCoordinator() -> HomeVCCoordinator {
        return HomeVCCoordinator()
    }
    
}
