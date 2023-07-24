////
////  ViewController.swift
////  SimpleApp
////
////  Created by Kno Harutyunyan on 13.07.23.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    // let's avoid polluting viewDidLoad
//    // {} is referred to as closure, or anonouyse functions
//
//    private let bearImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "bear_first"))
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//
//    private let descriptionTextView: UITextView = {
//        let textView = UITextView()
//        textView.translatesAutoresizingMaskIntoConstraints = false
//
//        let attributedText = NSMutableAttributedString(string: "Join us today in out fun and games", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
//
//        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
//
//        textView.attributedText = attributedText
//        textView.textAlignment = .center
//        textView.isEditable = false
//        textView.isScrollEnabled = false
//        return textView
//    }()
//
//    private let previousButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("PREV", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitleColor(.gray, for: .normal)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
//        return button
//    }()
//
//    private let nextButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("NEXT", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
//        button.setTitleColor(.mainPink, for: .normal)
//        return button
//    }()
//
//    private let pageControl: UIPageControl = {
//       let pc = UIPageControl()
//        pc.currentPage = 0
//        pc.numberOfPages = 4
//        pc.currentPageIndicatorTintColor = .mainPink
//        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
//        return pc
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        self.view.addSubview(descriptionTextView)
//        setupBottomControls()
//        setupLayout()
//    }
//
//    fileprivate func setupBottomControls() {
//
//        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
//
//        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
//        bottomControlsStackView.distribution = .fillEqually
//        self.view.addSubview(bottomControlsStackView)
//
//        NSLayoutConstraint.activate([
//            bottomControlsStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//            bottomControlsStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            bottomControlsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
//        ])
//    }
//
//    private func setupLayout() {
//        let topImageContainer = UIView()
//        self.view.addSubview(topImageContainer)
//        topImageContainer.translatesAutoresizingMaskIntoConstraints = false
//        topImageContainer.addSubview(bearImageView)
//
//
//        NSLayoutConstraint.activate([
//            topImageContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
//            topImageContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            topImageContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            topImageContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
//
//            bearImageView.centerXAnchor.constraint(equalTo: topImageContainer.centerXAnchor),
//            bearImageView.centerYAnchor.constraint(equalTo: topImageContainer.centerYAnchor),
//
//            bearImageView.heightAnchor.constraint(equalTo: topImageContainer.heightAnchor, multiplier: 0.5),
//
//
//            descriptionTextView.topAnchor.constraint(equalTo: topImageContainer.bottomAnchor),
//            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
//            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//    }
//
//}
//
//
