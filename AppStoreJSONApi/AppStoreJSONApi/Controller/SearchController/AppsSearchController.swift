//
//  AppsSearchController.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 08.08.23.
//

import UIKit
import SDWebImage

final class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private var appResults: [ResultModel] = []
    private var searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    private var currentSearchText: String?
    
    private lazy var enterSearchTermLabel: UILabel = {
       let label = UILabel()
        label.text = "Please enter search term above..."
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.anchor(top: collectionView.topAnchor, leading: collectionView.leadingAnchor, bottom: nil, trailing: collectionView.trailingAnchor, padding: UIEdgeInsets(top: 100, left: 20, bottom: 0, right: 20))
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor).isActive = true
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchControllerCellAndHeaderID.cellID)
        
        //fetchITunesApps()
        
        setupSearchBar()
        
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
    }
    
    fileprivate func fetchITunesApps() {
        Service.shared.fetchApps(searchTerm: "Twitter") { res, err in
            if let err = err {
                print("Failed to finish fetching apps.", err)
            }
            
            self.appResults = res
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc private func handleTimer() {
        guard let searchText = currentSearchText else {
            return
        }
        
        handleTimerForSearch(searchText)
    }

    private func handleTimerForSearch(_ searchText: String) {
        Service.shared.fetchApps(searchTerm: searchText) { res, err in
            if let err = err {
                print("Failed to finish fetching apps.", err)
            }
            
            self.appResults = res
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.timer?.invalidate()
        
        self.currentSearchText = searchText
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.enterSearchTermLabel.isHidden = self.appResults.count != 0
        return self.appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchControllerCellAndHeaderID.cellID, for: indexPath) as! SearchResultCell
        
        if indexPath.item > self.appResults.count {
            return cell
        }
        
        let apps = self.appResults[indexPath.item]
        cell.appResults = apps
        
        return cell
    }
}
