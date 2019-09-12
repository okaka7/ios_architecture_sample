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

class SearchViewController: UIViewController {
    
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
    private let adapter: SearchViewAdapter
    private let disposeBag = DisposeBag()
    
    init(adapter: SearchViewAdapter) {
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)
        #if DEBUG
        log.debug("ColourSearchViewController.init()!!!")
        #endif
        self.view.backgroundColor = .white
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
