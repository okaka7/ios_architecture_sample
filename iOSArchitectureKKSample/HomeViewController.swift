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
        layout.minimumInteritemSpacing = 3
        
        layout.itemSize = CGSize(width: 76.5 / 1.3, height: 76.5)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        self.view.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        self.view.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 86.5).isActive = true
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
        setupSubscrible()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _ = self.collectionView
    }
    
    private func setupSubscrible() {
        self.viewModel.outputs
            .topPhotosObservable
            .subscribe(onSuccess: { list in
                print("save")
                list?.list.enumerated().forEach { offset, entity in
                    let image: UIImage = .init(url: entity.urls.small)
                    if File.saveImage(image: image, path: "topImage\(offset + 1)") {
                        #if DEBUG
                        log.debug("savedPhotos")
                        #endif
                    }
                }
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

extension HomeViewController: UICollectionViewDataSource {
    
}
