//
//  AccountViewAdapter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol AccountViewInputPort: class {
    func getAccount()
}

final class AccountController: AccountViewInputPort {
    let useCase: UserAccountUseCaseInputPort
    
    init(useCase: UserAccountUseCaseInputPort) {
        self.useCase = useCase
    }
    
    func getAccount() {
        
    }
    
   
}

final class AccountViewPresenter {
    
}
