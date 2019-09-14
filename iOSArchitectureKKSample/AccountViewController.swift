//
//  ColourSettingViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

class AccountViewController: UIViewController, TransitionPreparationNotifiCation {
    
    lazy private(set) var preparationObsevable: Observable<Void> = {
        self.viewModel
            .outputs
            .accountObservable
            .map({ _ in () })
            .asObservable()
        }()
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "setting"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    private let viewModel: AccountViewModelType
    private let disposeBag = DisposeBag()
    init(viewModel: AccountViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        #if DEBUG
            log.debug("AccountViewController.init()!!!")
        #endif
        self.view.backgroundColor = .white
         self.setupSubscribe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(label)
    }
    
    func fetchAccount() {
        #if DEBUG
        log.debug("homeVC.fetchAccount")
        #endif
        self.viewModel.inputs.getAccount()
    }
    
    private func setupSubscribe() {
        self.viewModel
            .outputs
            .accountObservable.subscribe(onSuccess: {_ in
                #if DEBUG
                log.debug("getAccount")
                #endif
            }).disposed(by: disposeBag)
    }
}
