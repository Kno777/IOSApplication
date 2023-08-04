//
//  UserProfileHeader.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 28.07.23.
//

import UIKit
import Firebase

protocol UserProfileHeaderDelegate {
    func didChangeToListView()
    func didChangeToGridView()
}

class UserProfileHeader: UICollectionViewCell {
    
    var delegate: UserProfileHeaderDelegate?
    
    var user: UserModel? {
        didSet {
            print("Did set", user?.username ?? "")
            
            guard let profileImageUrl = user?.profileImageUrl else { return }
            
            profileImageView.loadImage(urlString: profileImageUrl)
            
            usernameLabel.text = user?.username
            
            setupEditFollowButton()
        }
    }
    
    private lazy var profileImageView: CustomImageView = {
       let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 100 / 2
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "grid"), for: .normal)
        //button.tintColor = UIColor(white: 0, alpha: 0.3)
        button.addTarget(self, action: #selector(handleChangeToGridView), for: .touchUpInside)
        return button
    }()
    
    private lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.3)
        button.addTarget(self, action: #selector(handleChangeToListView), for: .touchUpInside)
        return button
    }()
    
    private lazy var ribbonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.3)
        return button
    }()
    
    private lazy var usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "username"
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
         label.attributedText = attributedText
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.numberOfLines = 0
         return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
         label.attributedText = attributedText
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.numberOfLines = 0
         return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "8\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
         label.attributedText = attributedText
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.numberOfLines = 0
         return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handelEditProfileOrFollow), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: -12, width: 0, height: 0)
        
        setupBottomToolBar()
        
        setupUserStatsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleChangeToGridView() {
        listButton.tintColor = UIColor(white: 0, alpha: 0.3)
        gridButton.tintColor = .singUpButtonDarkBlueColor
        delegate?.didChangeToGridView()
    }
    
    @objc private func handleChangeToListView() {
        listButton.tintColor = .singUpButtonDarkBlueColor
        gridButton.tintColor = UIColor(white: 0, alpha: 0.3)
        delegate?.didChangeToListView()
    }
    
    @objc private func handelEditProfileOrFollow() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        
        guard let userId = user?.uid else { return }
        
        if editProfileFollowButton.titleLabel?.text == "Edit Profile" {
            return
        }
        
        if editProfileFollowButton.titleLabel?.text == "Unfollow" {
            // unfollow logic
            Database.database().reference().child("following").child(currentLoggedInUserId).child(userId).removeValue { err, ref in
                if let err = err {
                    print("Failed to unfollow user: \(self.user?.username ?? "") error: ", err)
                    return
                }
                
                print("Successfully unfollowed user: ", self.user?.username ?? "")
                
                self.setupFollowStyle()
                
            }
        } else {
            // follow logic
            let ref = Database.database().reference().child("following").child(currentLoggedInUserId)
            
            let values: [String: Any] = [userId: 1]
            ref.updateChildValues(values) { err, ref in
                if let err = err {
                    print("Failed to follow user: ", err)
                    return
                }
                
                print("Successfully followed user: ", self.user?.username ?? "")
                
                self.setupUnFollowStyle()
            }
        }
    }
    
    fileprivate func setupUnFollowStyle() {
        self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
        self.editProfileFollowButton.backgroundColor = .white
        self.editProfileFollowButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    fileprivate func setupFollowStyle() {
        self.editProfileFollowButton.setTitle("Follow", for: .normal)
        self.editProfileFollowButton.backgroundColor = .singUpButtonDarkBlueColor
        self.editProfileFollowButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    fileprivate func setupEditFollowButton() {
        
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        
        guard let userId = user?.uid else { return }
        
        if currentLoggedInUserId == userId {
            editProfileFollowButton.setTitle("Edit Profile", for: .normal)
        } else {
            // check if following
            let ref = Database.database().reference().child("following").child(currentLoggedInUserId).child(userId)
            
            ref.observeSingleEvent(of: .value) { snapshot in
                if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
                    self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
                } else {
                    self.setupFollowStyle()
                }
            } withCancel: { err in
                print("Failed to check if following: ", err)
            }
        }
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(editProfileFollowButton)
        
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, left: profileImageView.trailingAnchor, bottom: nil, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: -12, width: 0, height: 50)
        
        editProfileFollowButton.anchor(top: stackView.bottomAnchor, left: postsLabel.leadingAnchor, bottom: nil, right: followingLabel.trailingAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 34)
    }
    
    fileprivate func setupBottomToolBar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        topDividerView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        bottomDividerView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, ribbonButton])
        
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, left: safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
    }
    
    fileprivate func setupProfileImage() {
        
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
