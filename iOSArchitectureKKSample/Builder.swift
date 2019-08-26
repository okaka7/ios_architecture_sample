//
//  Builder.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import UIKit


final class Builder {
    static func buildAppCoordinator(window: UIWindow) -> AppCoordinator {
        let vc: SplashViewController = .init()
        
        let webAPIClient: UnsplashPhotoClient = UnsplashAPIProvider.init(tokenClosure: <#T##UnsplashAPIProvider.tokenClosure##UnsplashAPIProvider.tokenClosure##() -> UnsplashTokenValueObject#>)
        let repository: FetchPhotoRepository = FetchPhotoGateWay.init(client: <#T##UnsplashPhotoClient#>)
        let viewAdapter: SplashViewInput = SplashViewAdapter.init(useCase: PhotoPrepareUseCase.init(repository: <#FetchPhotoRepository#>),
                                                                  output: vc)
        vc.inject(controller: viewAdapter)
        
        let coordinator: AppCoordinator = .init(window: window,
                                                rootVC: vc)
        vc.inject(transitioner: coordinator)
        
        return  coordinator
    }
    
    static func buildMainTabCoordinator() -> MainTabCoordinator {
        return MainTabCoordinator()
    }
}
