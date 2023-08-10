//
//  AppDetailController.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 10.08.23.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var appId: String? {
        didSet {
            guard let appId = appId else { return }
            print("Here is my appID: ", appId)
            
            let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
            
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResultModel?, err) in
                if let err = err {
                    print("Failed to fetch data for this id: \(appId) and error: \(err)")
                }
                
                print(result?.results.first?.releaseNotes ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailControllerCellAndHeaderID.cellID)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailControllerCellAndHeaderID.cellID, for: indexPath) as! AppDetailCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}
