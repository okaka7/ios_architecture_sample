//
//  ColourSettingCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

final class AccountVCCoordinator: Coordinator, PreparationProtocol {
    lazy var naviVC: UINavigationController = {
        let naviVC: UINavigationController = .init(rootViewController: self.accountVC)
        naviVC.navigationBar.barStyle = .black
        naviVC.navigationBar.isTranslucent = false
        naviVC.tabBarItem.title = R.string.localizable.account()
        return naviVC
    }()
    
    private let accountVC: AccountViewController
    
    init(accountVC: AccountViewController) {
        accountVC.navigationItem.title = R.string.localizable.account()
        self.accountVC = accountVC
    }
    
    func start() {
        return
    }
    
    func prepare() {
        
    }
    
}

extension AccountVCCoordinator: TransitionPreparationNotifiCationTransmitter {
    var notification: Observable<Void> {
        return accountVC.preparationObsevable
    }
}
