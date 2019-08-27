//
//  ColourSearchViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/24.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy private var searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController

        return searchController
    }()
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "search"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    init() {
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
        
        self.view.addSubview(label)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _ = self.searchController
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
