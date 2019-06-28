//
//  ColourSearchViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

class ColourSearchViewController: UIViewController {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "category"
        label.center = self.view.center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(label)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
