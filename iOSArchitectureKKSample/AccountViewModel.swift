//
//  AccountViewModel.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/28.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AccountViewModelType: class {
    var inputs: AccountViewModelInputs { get }
    var outputs: AccountViewModelOutputs { get }
}

extension AccountViewModelType where Self: AccountViewModelInputs {
    var inputs: AccountViewModelInputs { return self }
}

extension AccountViewModelType where Self: AccountViewModelOutputs {
    var outputs: AccountViewModelOutputs { return self }
}

protocol AccountViewModelInputs: class {
    func getAccount()
}

protocol AccountViewModelOutputs: class {
    var accountObservable: Single<AccountUIEntity?> { get }
}

final class AccountViewModel: AccountViewModelType, AccountViewModelInputs, AccountViewModelOutputs {
    lazy private(set) var accountObservable: Single<AccountUIEntity?> = {
        self.accountRelay.take(1).asSingle()
    }()
    
    let accountRelay: PublishRelay<AccountUIEntity?> = .init()
        
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
