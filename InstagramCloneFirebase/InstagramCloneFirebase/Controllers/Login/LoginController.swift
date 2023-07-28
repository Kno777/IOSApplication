//
//  LoginController.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 28.07.23.
//

import UIKit

class LoginController: UIViewController {
    
    private lazy var logoContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .logoContainerViewBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFill
        logo.image = UIImage(named: "Instagram_logo_white")?.withRenderingMode(.alwaysOriginal)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedText = NSMutableAttributedString(string: "Don't have account?", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedText.append(NSAttributedString(string: " Sign Up.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.singUpButtonDarkBlueColor]))
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.titleLabel?.textColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handelDontHaveAccount), for: .touchUpInside)
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
        //email.addTarget(self, action: #selector(handelEmailTextInputChange), for: .editingChanged)
        return email
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
        //password.addTarget(self, action: #selector(handelEmailTextInputChange), for: .editingChanged)
        return password
    }()
    
    private lazy var loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.setTitle("Login", for: .normal)
        login.backgroundColor = .signUpButtonBlueColor
        login.layer.cornerRadius = 5
        login.titleLabel?.font = .boldSystemFont(ofSize: 14)
        login.setTitleColor(.white, for: .normal)
        //login.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
        login.isEnabled = false
        return login
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(dontHaveAccountButton)
        
        view.addSubview(logoContainerView)
        
        logoContainerView.addSubview(logoImageView)
        
        dontHaveAccountButton.anchor(top: nil, left: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        logoContainerView.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        
        logoImageView.centerYAnchor.constraint(equalTo: logoContainerView.centerYAnchor, constant: 10).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor).isActive = true
        
        setupInputFields()
        
    }
    
    @objc private func handelDontHaveAccount() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        
        stackView.axis = .vertical
        
        stackView.spacing = 10
        
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, width: 0, height: 140)
    }
}
