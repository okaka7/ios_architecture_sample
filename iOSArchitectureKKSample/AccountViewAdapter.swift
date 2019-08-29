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
    func getAccount() {
        
    }
    
   
}

final class AccountViewPresenter {
    
}
