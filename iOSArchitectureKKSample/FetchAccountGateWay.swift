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
        self.client.re
    }
    
    func fetchPhotos() -> Single<UnsplashUserPhotosTarget.Response> {
        <#code#>
    }
    
    func fetchCollection() -> Single<UnsplashUserCollectionsTarget.Response> {
        <#code#>
    }
    
    func fetchPortfolioURL() -> Single<UnsplashUserPortfolioTarget.Response> {
        <#code#>
    }
    
    

}
