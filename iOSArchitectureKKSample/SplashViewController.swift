//
//  ViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import KeychainAccess

//protocol UnsplashAuthenticationOutput where Self: UIViewController {
//    func openAuthenticationURL(_ url: URL, completionHandler completion: ((Bool) -> Void)?)
//}

class SplashViewController: UIViewController {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "splash"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    weak private var transitioner: SplashTransitioner!
    private let controller: SplashControllerProtocol
    let viewModel: SplashViewModelProtocol

    init(controller: SplashControllerProtocol,
         viewModel: SplashViewModelProtocol) {
        self.controller = controller
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(label)
     //   self.
        self.prepareForDisplayingPhotos()
        self.prepareForCategoryPhotos()
        self.prepareForAccountView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func prepareForDisplayingPhotos() {
        controller.fetchPopularPhotos()
        self.transitioner?.transition()
    }
    
    private func prepareForCategoryPhotos() {
        controller.fetchPopularPhotos()
    }
    
    private func prepareForAccountView() {
        controller.fetchAccount()
    }
    
    private func subscribeRx() {
        
        viewModel.prepareObservable.subscribe(onNext: { assets in
            switch assets {
                case is
            }
        },
            onCompleted: )
    }
  
}

extension SplashViewController: SplashTransitionerInjectable {
    func inject(transitioner: SplashTransitioner) {
        self.transitioner = transitioner
    }
}


