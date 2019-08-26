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

class SplashViewController: UIViewController, SplashViewPresenter {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "splash"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    weak private var transitioner: SplashTransitioner! 
    private var controller: SplashViewInput!

    init() {
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func fetchTopImage() {
        
        
        controller.fetchTopImages()
        
        self.transitioner?.transition()
        
    }
}

extension SplashViewController: SplashTransitionerInjectable {
    func inject(transitioner: SplashTransitioner) {
        self.transitioner = transitioner
    }
}

extension SplashViewController: SplashControllerInjectable{
    func inject(controller: SplashViewInput) {
        self.controller = controller
    }
}

//extension SplashViewController: UnsplashAuthenticationOutput { }
//
//extension UnsplashAuthenticationOutput {
//    func openAuthenticationURL(_ url: URL, completionHandler completion: ((Bool) -> Void)? = nil) {
//        UIApplication.shared.openURLIfPossible(url,
//                                               options: [:],
//                                               completionHandler: completion)
//
//    }
//}
