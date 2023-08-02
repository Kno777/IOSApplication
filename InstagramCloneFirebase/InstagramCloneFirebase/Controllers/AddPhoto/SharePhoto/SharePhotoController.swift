//
//  SharePhotoController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 30.07.23.
//

import UIKit
import Firebase
import FirebaseStorage


class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    private lazy var imageView: UIImageView = {
       let image = UIImageView()
        //image.backgroundColor = .red
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var textView: UITextView = {
       let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.textColor = .black
        tv.font = .systemFont(ofSize: 14)
        return tv
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .shareControllerBackgroundGrayColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handelShare))
        
        setupImageAndTextViews()
    }
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(textView)
        
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        imageView.anchor(top: containerView.topAnchor, left: containerView.leadingAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: -8, paddingRight: 0, width: 84, height: 0)
        
        textView.anchor(top: containerView.topAnchor, left: imageView.trailingAnchor, bottom: containerView.bottomAnchor, right: containerView.trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc private func handelShare() {
        
        guard let postText = textView.text, postText.count > 0 else { return }
        
        guard let image = selectedImage else { return }
        
        guard let uploadImage = image.jpegData(compressionQuality: 0.5) else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = UUID().uuidString
        
        let storageRef = Storage.storage().reference().child("posts").child(filename)
        
        storageRef.putData(uploadImage) { metaData, err in
            
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to upload image to storage.", err)
                return
            }
            
            
            storageRef.downloadURL { url, err in
                if let err = err {
                    print("Failed to get download URL: ", err)
                    return
                }
                
                guard let imageDownloadURL = url else {
                    print("Download URL is nil.")
                    return
                }
                print("Successfully uploaded post image: ", imageDownloadURL.absoluteString)
                
                self.saveToDatabaseWithImageUrl(imageUrl: imageDownloadURL.absoluteString)
            }
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        guard let postImage = selectedImage else { return }
        guard let postText = textView.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid)
        
        let ref = userPostRef.childByAutoId()
        
        let values: [String: Any] = [
            "imageUrl": imageUrl,
            "postText": postText,
            "imageWidth": postImage.size.width, "imageHeight": postImage.size.height,
            "creationDate": Date().timeIntervalSince1970
        ]
        
        ref.updateChildValues(values) { err, ref in
            
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to update values to database. ", err)
                return
            }
            
            print("Successfully save post to database.")
            self.dismiss(animated: true)
            
            let name = NSNotification.Name(rawValue: NotificationCenterForUpdateHomeFeed.name)
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
}


