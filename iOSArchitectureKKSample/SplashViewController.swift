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
    func openAuthenticationURL(_ url: URL, completionHandler completion: ((Bool) -> Void)?)
}


class SplashViewController: UIViewController {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "colour"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    weak var transitioner: SplashTransitioner?

    init(transition: SplashTransitioner) {
        self.transitioner = transition
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
            self.transitioner?.transition()
            //note: splash画面でのトークン処理が必要ではならなくなったのでコメントアウト。ただどこかの画面で流用する可能性もあるのでコメントアウトで削除はしない
//            if let token = KeychainStore.unsplashToken {
//                #if DEBUG
//                log.debug(token)
//                #endif
//            } else {
//                let authentication = OauthAuthenticationGateway(outputView: self)
//                authentication.authenticate()
//            }

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
