//
//  AccountViewAdapter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift

protocol AccountViewInputPort: class {
    func getAccount()
}

final class AccountViewAdapter: AccountViewInputPort {
    let useCase: UserAccountUseCaseInputPort
    private let disposeBag: DisposeBag
    
    init(useCase: UserAccountUseCaseInputPort,
         disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    
    func getAccount() {
        self.useCase
            .getAccount()
            .subscribe(onSuccess: {_ in},
                        onError: {_ in })
            .disposed(by: disposeBag)
        
    }
}

final class AccountViewPresenter {
    
}
