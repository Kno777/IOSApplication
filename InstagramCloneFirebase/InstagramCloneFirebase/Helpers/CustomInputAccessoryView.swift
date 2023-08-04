//
//  CustomInputAccessoryView.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit

protocol CustomInputAccessoryViewDelegate {
    func didSubmit(for comment: String)
}

class CustomInputAccessoryView: UIView, UITextViewDelegate {
    
    var delegate: CustomInputAccessoryViewDelegate?
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.text = "Enter comment..."
        textView.font = .systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    private lazy var submitedButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitleColor(.systemBlue, for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return submitButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        
        commentTextView.delegate = self
        
        addSubview(submitedButton)
        addSubview(commentTextView)
        
        self.submitedButton.anchor(top: topAnchor, left: nil, bottom: safeAreaLayoutGuide.bottomAnchor, right: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -12, width: 50, height: 0)
        
        self.commentTextView.anchor(top: topAnchor, left: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: submitedButton.leadingAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleSubmit() {
        guard let comment = commentTextView.text, comment.count > 0 else { return}
        delegate?.didSubmit(for: comment)
    }
    
    func clearCommentWhenSuccessued() {
        self.commentTextView.text = nil
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = .lightGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter comment..."
            textView.textColor = .lightGray
        }
    }
}
