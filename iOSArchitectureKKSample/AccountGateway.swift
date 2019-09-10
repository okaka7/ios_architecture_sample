//
//  AccountGateway.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

import RxSwift

struct AccountGateWay: AccountRepository {
    let client: UnsplashUserAccountClient
    
    init(client: UnsplashUserAccountClient) {
        self.client = client
    }
    func fetchAccount() -> Single<UnsplashAccountTarget.Response> {
        return client.requestAccount()
    }
    
    func fetchUserPhotos(userName name: String) -> Single<UnsplashUserPhotosTarget.Response> {
        return client.requestUserPhotos(userName: name)
    }
    
    func fetchUserCollections(userName name: String) -> Single<UnsplashUserCollectionsTarget.Response> {
        return client.requestUserCollections(userName: name)
    }
    
    func fetchPortfolioURL(userName name: String) -> Single<UnsplashUserPortfolioTarget.Response> {
        return client.requestUserPortfolio(userName: name)
    }
}
