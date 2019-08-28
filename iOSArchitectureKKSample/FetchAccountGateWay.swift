//
//  FetchAccountGateWay.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

struct FetchAccountGateWay: AccountRepository {
    let client: UnsplashUserAccountClient
    
    init(client: UnsplashUserAccountClient) {
        self.client = client
    }
    
    func fetchAccount() -> Single<UnsplashAccountTarget.Response> {
        return self.client.requestAccount()
    }
    
    func fetchUserPhotos(userName name: String) -> Single<UnsplashUserPhotosTarget.Response> {
        return self.client.requestUserPhotos(userName: name)
    }
    
    func fetchUserCollections(userName name: String) -> Single<UnsplashUserCollectionsTarget.Response> {
        return self.client.requestUserCollections(userName: name)
    }
    
    func fetchPortfolioURL(userName name: String) -> Single<UnsplashUserPortfolioTarget.Response> {
        return self.client.requestUserPortfolio(userName: name)
    }
}
