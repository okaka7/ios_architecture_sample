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
        let useCase: SplashUseCase = .init()
        let viewModel: SplashViewModel = .init(useCase: useCase)
        let vc: SplashViewController = .init(viewModel: viewModel)
        let mainTabCoordinator: MainTabCoordinator = buildMainTabCoordinator()
        
        let coordinator: AppCoordinator = .init(window: window,
                                                rootVC: vc,
                                                mainTabCoordinator: mainTabCoordinator)
        
        return  coordinator
    }
    
    static func buildMainTabCoordinator() -> MainTabCoordinator {
        let homeCoordinator: HomeVCCoordinator = buildHomeVCCoordinator()
        let searchCoordinator: SearchVCCoordinator = buildSearchVCCoordinator()
        let accountCoordinator: AccountVCCoordinator = buildAccountVCCoordinator()
        return MainTabCoordinator(homeCoordinator: homeCoordinator,
                                  searchCoordinator: searchCoordinator, accountCoordinator: accountCoordinator)
    }
    
    static func buildHomeVCCoordinator() -> HomeVCCoordinator {
        let webAPIClient: UnsplashAPIProvider = .shared
        let repository: PhotoGateWay = .init(client: webAPIClient)
        let useCase: HomeUseCase = .init(photoRepository: repository)
        let viewModel: HomeViewModel = .init(useCase: useCase)
        let vc: HomeViewController = .init(viewModel: viewModel)
        return HomeVCCoordinator(homeVC: vc)
    }
    
    static func buildSearchVCCoordinator() -> SearchVCCoordinator {
        let webAPIClient: UnsplashAPIProvider = .shared
        let repository: PhotoGateWay = .init(client: webAPIClient)
        let useCase: SearchUseCase = .init(repository: repository)
        let viewModel: SearchViewModel = .init(useCase: useCase)
        let vc: SearchViewController = .init(viewModel: viewModel)
        return SearchVCCoordinator.init(searchVC: vc)
    }
    
    static func buildAccountVCCoordinator() -> AccountVCCoordinator {
        let webAPIClient: UnsplashAPIProvider = .shared
        let repository: AccountGateWay = .init(client: webAPIClient)
        let useCase: AccountUseCase = .init(repository: repository)
        let viewModel: AccountViewModel = .init(useCase: useCase)
        let vc: AccountViewController = .init(viewModel: viewModel)
        return AccountVCCoordinator.init(accountVC: vc)
    }
}
