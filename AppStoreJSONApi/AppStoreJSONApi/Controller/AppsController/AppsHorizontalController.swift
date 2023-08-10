//
//  AppsHorizontalController.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import UIKit

final class AppsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var appGroup: AppGroupModel?
    
    var didSelectHandler: ((FeedResultModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppsHorizontalControllerCellAndHeaderID.cellID)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        // MARK: - Change UICollectionView direction to horizontal
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            self.didSelectHandler?(app)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 24 - 20) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHorizontalControllerCellAndHeaderID.cellID, for: indexPath) as! AppRowCell
        
        guard let app = self.appGroup?.feed.results[indexPath.item] else { return cell }
        
        cell.nameLabel.text = app.name
        cell.companyLabel.text = app.artistName
        cell.imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        
        return cell
    }
}
