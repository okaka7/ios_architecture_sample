//
//  ColourCategoryViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy private(set) var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        self.view.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        self.view.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        return collectionView
    }()

    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "category"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        #if DEBUG
        log.debug("ColourCategoryViewController.init()!!!")
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
    
    override func viewWillAppear(_ animated: Bool) {
        _ = self.collectionView
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



