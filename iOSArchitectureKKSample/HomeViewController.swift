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
import RxDataSources
import Nuke

class HomeViewController: UIViewController, TransitionPreparationNotifiCation {

    lazy private(set) var preparationObsevable: Observable<Void> = {
        self.viewModel
            .outputs
            .topPhotosObservable
            .map({ _ in () })
            .do(onNext: { _ in
                #if DEBUG
                log.debug("preparationObservable📔")
                #endif
            })
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
                            forCellWithReuseIdentifier: R.string.localizable.homePhotoCell())
        collectionView.allowsMultipleSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let viewModel: HomeViewModelType
    let disposeBag: DisposeBag = .init()
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = R.color.background()
        
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
        
        let configureCell: RxCollectionViewSectionedReloadDataSource<SectionOfTopImage>.ConfigureCell = { dataSource, collectionView, indexPath, item in
            let photoIdentifier: String = R.string.localizable.homePhotoCell()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoIdentifier,
                                                          for: indexPath) as! CollectionPhotoViewCell
            
            cell.configureImage(imageURL: item.photoURL)

            return cell
            
        }
        
         let dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfTopImage> = .init(configureCell: configureCell)
        
        self.viewModel.outputs
            .topPhotosObservable
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.disposeBag)
        
        self.collectionView.rx.itemSelected
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: self.disposeBag)
        
    }

    func fetchTopPhotos(page: Int = 1) {
        viewModel.inputs.fetchTopPhotos(page: page, photos: [])
    }

}
