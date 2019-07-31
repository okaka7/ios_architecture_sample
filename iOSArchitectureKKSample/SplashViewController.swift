//
//  ViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import KeychainAccess

protocol UnsplashAuthenticationOutput where Self: UIViewController {
    func openAuthenticationURL(_ url: URL, completionHandler completion: ((Bool)->Void)?)
}


class SplashViewController: UIViewController {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "colour"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    weak var transition: TransitionToMainTabVC?

    init(transition: TransitionToMainTabVC) {
        self.transition = transition
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: { [weak self] in
            guard let self = self else {
                return
            }
            if let token: String = ColourKeychainAccess.dribbbleToken {
                log.debug(token)
            } else {
                let authentication = UnsplashOauthAuthentication(outputView: self)
                authentication.authenticate()
            }
            
        })

    }
}

extension SplashViewController: UnsplashAuthenticationOutput { }

extension UnsplashAuthenticationOutput {
    func openAuthenticationURL(_ url: URL, completionHandler completion: ((Bool) -> Void)? = nil) {
        UIApplication.shared.openURLIfPossible(url,
                                               options: [:],
                                               completionHandler: completion)
        
    }
}
