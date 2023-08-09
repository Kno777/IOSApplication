//
//  AppsSearchController.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 08.08.23.
//

import UIKit

final class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var appResults: [ResultModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: "cellId")
        
        fetchITunesApps()
        
    }
    
    fileprivate func fetchITunesApps() {
        Service.shared.fetchApps { res, err in
            if let err = err {
                print("Failed to finish fetching apps.", err)
            }
            self.appResults = res
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SearchResultCell
        
        let apps = self.appResults[indexPath.item]
        
        cell.appLabel.text = apps.trackName
        cell.categoryLabel.text = apps.primaryGenreName
        cell.ratingsLabel.text = "Ratings: \(apps.averageUserRating)"
        
        return cell
    }
}
