//
//  UserProfileHeader.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 28.07.23.
//

import UIKit
import Firebase

class UserProfileHeaderCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            print("Did set", user?.username ?? "")
            setupProfileImage()
        }
        
    }
    
    private lazy var profileImageView: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 100 / 2
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupProfileImage() {
        
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
//
//            guard let dictionary = snapshot.value as? [String: Any] else { return }
//
//            let _ = dictionary["username"] as? String
//
//        } withCancel: { err in
//            print("Failed to fetch user: ", err)
//        }
        
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            
            if let err = err {
                print("Failed to fetch user profile picture: ", err)
                return
            }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            // need to get back onto the MAIN UI thread
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
        }.resume()
    }
}
