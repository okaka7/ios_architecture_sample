//
//  ColourSettingViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "setting"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    private let adapter: AccountViewAdapter
    
    init(adapter: AccountViewAdapter) {
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)
        #if DEBUG
            log.debug("AccountViewController.init()!!!")
        #endif
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(label)
    }
}
