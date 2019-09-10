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

enum Category: String, CaseIterable {
    case nature
    case travel
    case animal
    case fashion
    case art
    case architecture
    
    var image: UIImage {
        switch self {
        case .nature:
            return #imageLiteral(resourceName: "nature")
        case .travel:
            return #imageLiteral(resourceName: "travel")
        case .animal:
            return #imageLiteral(resourceName: "animal")
        case .fashion:
            return #imageLiteral(resourceName: "fashion")
        case .art:
            return #imageLiteral(resourceName: "art")
        case .architecture:
            return #imageLiteral(resourceName: "architecture")
        }
    }
}

final class AppBuilder {
    static func buildAppCoordinator(window: UIWindow) -> AppCoordinator {
        let webAPIClient: UnsplashAPIProvider = .shared
        let repository: PhotoGateWay = .init(client: webAPIClient)
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
