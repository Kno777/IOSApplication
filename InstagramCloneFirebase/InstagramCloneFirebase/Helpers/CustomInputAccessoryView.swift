//
//  CustomInputAccessoryView.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit

class CustomInputAccessoryView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        //containerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50)
        
        addSubview(containerView)
        
        containerView.anchor(top: nil, left: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, right: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.systemBlue, for: .normal)
        submitButton.addTarget(self, action: #selector(handelSubmit), for: .touchUpInside)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        containerView.addSubview(submitButton)
        
        submitButton.anchor(top: containerView.topAnchor, left: nil, bottom: containerView.bottomAnchor, right: containerView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -12, width: 50, height: 0)
        
        let textField = UITextField()
        textField.placeholder = "Enter a comment"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(textField)
        
        textField.anchor(top: nil, left: containerView.leadingAnchor, bottom: containerView.bottomAnchor, right: submitButton.leadingAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handelSubmit() {
        print("dddd")
    }
}
