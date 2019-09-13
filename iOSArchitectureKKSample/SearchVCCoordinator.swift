//
//  ColourSearchCoordinator.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/27.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

final class SearchVCCoordinator: Coordinator, PreparationProtocol {
    
    lazy var naviVC: UINavigationController = {
        let naviVC: UINavigationController = .init(rootViewController: self.searchVC)
        naviVC.navigationBar.barStyle = .black
        naviVC.navigationBar.isTranslucent = false
        naviVC.tabBarItem.title = R.string.localizable.search()
        return naviVC
    }()
    
    private let searchVC: SearchViewController
    
    init(searchVC: SearchViewController) {
        searchVC.navigationItem.title = R.string.localizable.search()
        self.searchVC = searchVC
    }
    func start() {
        
    }
    
    func prepare() {
        self.searchVC.fetchPopluarPhoto()
    }
}

extension SearchVCCoordinator: TransitionPreparationNotifiCationTransmitter {
    var notification: Observable<Void> {
        return searchVC.preparationObsevable
    }
}
