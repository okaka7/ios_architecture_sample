//
//  ColourCategoryViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController, TransitionPreparationNotifiCation {

    lazy private(set) var preparationObsevable: Observable<Void> = {
        self.viewModel
            .outputs
            .topPhotosObservable
            .map({ _ in () })
            .do(onSuccess: {_ in
                #if DEBUG
                log.debug("preparationObservable📔")
                #endif
            })
            .asObservable()
    }()

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
        collectionView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        return collectionView
    }()
    
    let viewModel: HomeViewModelType
    let disposeBag: DisposeBag = .init()
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _ = self.collectionView
    }
    
    private func setupSubscrible() {
        self.viewModel.outputs
            .topPhotosObservable
            .subscribe(onSuccess: {_ in
               
            })
            .disposed(by: disposeBag)
    }

    func fetchTopPhotos(page: Int = 1) {
        #if DEBUG
        log.debug("getTopPhotos")
        #endif
        
        viewModel.inputs.fetchTopPhotos(page: page, photos: PhotoUIList())
    }

}
