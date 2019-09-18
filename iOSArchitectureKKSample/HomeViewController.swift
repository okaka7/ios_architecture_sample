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
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: 82.5 / 1.3, height: 82.5)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        self.view.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 86.5).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
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
    
    let viewModel: HomeViewModelType
    let disposeBag: DisposeBag = .init()
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        #if DEBUG
            log.debug("ColourCategoryViewController.init()!!!")
        #endif
        self.view.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.08235294118, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubscrible()
         _ = self.collectionView
        print(collectionView.contentSize.width)
        
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
