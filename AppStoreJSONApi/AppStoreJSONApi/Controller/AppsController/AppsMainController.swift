//
//  AppsController.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

final class AppsMainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var appsGroup: [AppGroupModel] = []
    var socialApps: [SocialAppsHeaderModel] = []
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.startAnimating()
        activity.color = .black
        activity.hidesWhenStopped = true
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsMainControllerCellAndHeaderID.cellID)
        
        collectionView.register(AppsTopHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsMainControllerCellAndHeaderID.headerID)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
        fetchSocial()
    }
    
    fileprivate func fetchSocial() {
        print("Fetching social JSON Data...")
        
        Service.shared.fetchSocialAppsHeader { social, err in
            if let err = err {
                print("Failed to fetch social data...", err)
                return
            }
            
            guard let social = social else { return }
            
            self.socialApps = social
            
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
           
        }
    }
    
    fileprivate func fetchData() {
        print("Fetching new JSON data...")
        Service.shared.fetchApps { appGroup, err in
            if let err = err {
                print("Failed to fetch games from AppsMainController.", err)
                return
            }
            guard let appGroup = appGroup else { return }
            
            
            self.appsGroup.append(appGroup)
            
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsMainControllerCellAndHeaderID.headerID, for: indexPath) as! AppsTopHeader
        
        
        header.appHeaderHorizontalController.socialAppsHeader = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appsGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsMainControllerCellAndHeaderID.cellID, for: indexPath) as! AppsGroupCell
        
        cell.appSectionLabel.text = appsGroup[indexPath.item].feed.title
        cell.horizontalViewController.appGroup = self.appsGroup[indexPath.item]
        cell.horizontalViewController.didSelectHandler = { [weak self] feedResult in
            
            let appDetailController = AppDetailController()
            appDetailController.view.backgroundColor = .white
            appDetailController.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(appDetailController, animated: true)
            
        }
        //cell.horizontalViewController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}
