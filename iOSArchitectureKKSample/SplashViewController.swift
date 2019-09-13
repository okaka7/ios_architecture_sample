//
//  ViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift
import KeychainAccess

extension Notification.Name {
    static let transitionToMainTab = Notification.Name(rawValue: "toMainTab")
}

class SplashViewController: UIViewController {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "splash"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    let viewModel: SplashViewModelType
    private let disposeBag: DisposeBag

    init(viewModel: SplashViewModelType,
         disposeBag: DisposeBag = DisposeBag()) {
        self.viewModel = viewModel
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.addObserverForTransition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(label)
        self.prepareForMainTab()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    private func addObserverForTransition() {
        _ = NotificationCenter.default
            .addObserver(forName: .transitionToMainTab,
                         object: nil,
                         queue: nil,
                         using: transition(_:))
    }
    
    private func prepareForMainTab() {
        viewModel.inputs.prepareForMainTab()
    }
    
    private func transition(_ : Notification) {
        viewModel.inputs.transition()
    }
  
}
