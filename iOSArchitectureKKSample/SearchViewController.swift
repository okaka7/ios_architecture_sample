//
//  ColourSearchViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController, TransitionPreparationNotifiCation {
    
    lazy private(set) var preparationObsevable: Observable<Void> = {
        self.viewModel
            .outputs
            .popluarPhotosObservable
            .map({ _ in () })
            .asObservable()
    }()

    lazy private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        return searchController
    }()

    lazy private var button: UIButton = {
        let button: UIButton = .init(frame: .zero)
        button.setTitle("button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.sizeToFit()
        button.center = self.view.center
        return button
    }()
    private let viewModel: SearchViewModelType
    private let disposeBag = DisposeBag()
    
    init(viewModel: SearchViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        #if DEBUG
        log.debug("ColourSearchViewController.init()!!!")
        #endif
        self.view.backgroundColor = .white
        self.setupSubscribe()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.view.addSubview(label)
        self.view.addSubview(button)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _ = self.searchController
        
        button.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            self.searchController.isActive = !self.searchController.isActive
        }).disposed(by: disposeBag)
    }

    func fetchPopluarPhoto() {
        viewModel.inputs.fetchPopularPhotos()
    }
    
    private func setupSubscribe() {
        self.viewModel
            .outputs
            .popluarPhotosObservable
            .subscribe(onSuccess: <#T##((PopularPhotoList?) -> Void)?##((PopularPhotoList?) -> Void)?##(PopularPhotoList?) -> Void#>,
                       onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>)
    }

}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // SearchBarに入力したテキストを使って表示データをフィルタリングする。
        let text = searchController.searchBar.text ?? ""
        if text.isEmpty {
           // filteredTitles = titles
        } else {
           // filteredTitles = titles.filter { $0.contains(text) }
        }
        //tableView.reloadData()
    }
}
