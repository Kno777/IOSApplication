//
//  ViewController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 26.07.23.
//

import Firebase
import FirebaseStorage
import UIKit

class ViewController: UIViewController {
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handelPlusPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailTextField: UITextField = {
      let email = UITextField()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.textColor = .black
        email.backgroundColor = UIColor(white: 0, alpha: 0.05)
        email.borderStyle = .roundedRect
        email.font = .systemFont(ofSize: 14)
        email.layer.borderWidth = 0.5
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.layer.cornerRadius = 10
        email.attributedPlaceholder = placeholderTextandColor(title: "Email", color: .lightGray, fontSize: 14)
        email.addTarget(self, action: #selector(handelEmailTextInputChange), for: .editingChanged)
        return email
    }()
    
    private lazy var usernameTextField: UITextField = {
      let username = UITextField()
        username.translatesAutoresizingMaskIntoConstraints = false
        username.textColor = .black
        username.backgroundColor = UIColor(white: 0, alpha: 0.05)
        username.borderStyle = .roundedRect
        username.font = .systemFont(ofSize: 14)
        username.layer.borderWidth = 0.5
        username.layer.borderColor = UIColor.lightGray.cgColor
        username.layer.cornerRadius = 10
        username.attributedPlaceholder = placeholderTextandColor(title: "Username", color: .lightGray, fontSize: 14)
        username.addTarget(self, action: #selector(handelEmailTextInputChange), for: .editingChanged)
        return username
    }()
    
    private lazy var passwordTextField: UITextField = {
      let password = UITextField()
        password.isSecureTextEntry = true
        password.textColor = .black
        password.translatesAutoresizingMaskIntoConstraints = false
        password.backgroundColor = UIColor(white: 0, alpha: 0.05)
        password.borderStyle = .roundedRect
        password.font = .systemFont(ofSize: 14)
        password.layer.borderWidth = 0.5
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.cornerRadius = 10
        password.attributedPlaceholder = placeholderTextandColor(title: "Password", color: .lightGray, fontSize: 14)
        password.addTarget(self, action: #selector(handelEmailTextInputChange), for: .editingChanged)
        return password
    }()
    
    
    private lazy var signUpButton: UIButton = {
        let signUp = UIButton(type: .system)
        signUp.setTitle("Sign Up", for: .normal)
        signUp.backgroundColor = .signUpButtonBlueColor
        signUp.layer.cornerRadius = 5
        signUp.titleLabel?.font = .boldSystemFont(ofSize: 14)
        signUp.setTitleColor(.white, for: .normal)
        signUp.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
        signUp.isEnabled = false
        return signUp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        
        view.addSubview(plusPhotoButton)
        
        setupInputFields()
        
        NSLayoutConstraint.activate([
            plusPhotoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
    }
    
    @objc private func handelPlusPhoto() {
        print("Attemting to uploud photo from device.")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true)
    }
    
    @objc private func handelEmailTextInputChange() {
        
        let isFormValied = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValied {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .singUpButtonDarkBlueColor
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .signUpButtonBlueColor
        }
        
    }
    
    @objc private func handelSignUp() {
        print("Attemting to singUp user.")
        
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, err in
            
            if let err = err {
                print("Falied to create user.", err)
                return
            }
            
            print("Successfully created user: ", user?.user.uid ?? "")
            
            guard let image = self.plusPhotoButton.imageView?.image else { return }
            
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            let filename = UUID().uuidString
            
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
            
            storageRef.putData(uploadData) { metaData, err in
                if let err = err {
                    print("Failed to upload profile image: ", err)
                    return
                }
                
                storageRef.downloadURL { url, err in
                    if let err = err {
                        print("Failed to get download URL: ", err)
                        return
                    }
                    
                    guard let downloadURL = url else {
                        print("Download URL is nil.")
                        return
                    }
                    
                    let profileImageUrl = downloadURL.absoluteString
                    print("Successfully uploaded profile image.", profileImageUrl)
                    
                    guard let user = user else { return }

                    let userDictionaryValues = ["username": username, "profileImageUrl": profileImageUrl]
                    let values = [user.user.uid: userDictionaryValues]

                    Database.database().reference().child("users").updateChildValues(values) { err, dbRef in

                        if let err = err {
                            print("Failed to save user into database.", err)
                            return
                        }

                        print("Successfully saved user info into database. ")

                    }

                }
                
            }
            
        }
    }

    fileprivate func setupInputFields() {
     
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10

        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, width: 0, height: 200)
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            plusPhotoButton.setImage(editingImage.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
                
        dismiss(animated: true)
    }
}
