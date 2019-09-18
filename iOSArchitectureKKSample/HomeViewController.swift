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
import Nuke

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
        layout.minimumLineSpacing = Const.Size.Home.photoCollectionItemLineSpace
        layout.itemSize = Const.Size.Home.photoCollectionItemSize
        layout.sectionInset = Const.Size.Home.photoCollectionInsets
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.widthAnchor
            .constraint(equalTo: self.view.widthAnchor)
            .isActive = true
        collectionView.heightAnchor
            .constraint(equalToConstant: Const.Size.Home.photoCollectionHeight)
            .isActive = true
        collectionView.topAnchor
            .constraint(equalTo: self.view.topAnchor)
            .isActive = true
        collectionView.register(CollectionPhotoViewCell.self,
                            forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy private(set) var photo: [UIImage] = {
        let images: [UIImage] = Array(1...12).compactMap {
            if let image: UIImage = File.loadImageFromPath(path: "topImage\($0)"){
                return image
            } else {
                return nil
            }
        }
        
        return images
    }()

    private let viewModel: HomeViewModelType
    let disposeBag: DisposeBag = .init()
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.08235294118, alpha: 1)
        
        #if DEBUG
        log.debug("ColourCategoryViewController.init()🤖🤖🤖")
        #endif
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubscrible()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        _ = self.collectionView
    }
    
    private func setupSubscrible() {
        self.viewModel.outputs
            .topPhotosObservable
            .subscribe(onSuccess: { list in
            })
            .disposed(by: disposeBag)
    }

    func fetchTopPhotos(page: Int = 1) {
        viewModel.inputs.fetchTopPhotos(page: page, photos: PhotoUIList())
    }

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionPhotoViewCell
        cell.configureImage(image: photo[indexPath.row])
        return cell
    }
}
