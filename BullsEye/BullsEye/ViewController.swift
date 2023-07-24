//
//  ViewController.swift
//  BullsEye
//
//  Created by Kno Harutyunyan on 13.07.23.
//

import UIKit

class ViewController: UIViewController {
    
    var sliderCurrentValue: Int = 1
    
    var currentValue: Int = Int.random(in: 1...100) {
        didSet {
            myTitle.text = "stex petq lini title u plyus tivy: \(currentValue)"
        }
    }
    
    var score: Int = 0 {
        didSet {
            myScore.text = "Score: \(score)"
        }
    }
    var round: Int = 0 {
        didSet {
            myRound.text = "Round: \(round)"
        }
    }
    
    private lazy var myTitle: UILabel = {
       let title = UILabel()
        title.text = "stex petq lini title u plyus tivy: \(currentValue)"
        title.textColor = .white
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .boldSystemFont(ofSize: 26)
        title.lineBreakMode = .byTruncatingMiddle
        title.textAlignment = .center
        return title
    }()
    
    private lazy var startOne: UILabel = {
       let start = UILabel()
        start.text = "1"
        start.textColor = .white
        start.numberOfLines = 0
        start.translatesAutoresizingMaskIntoConstraints = false
        start.font = .boldSystemFont(ofSize: 26)
        return start
    }()
    
    private lazy var endHundred: UILabel = {
       let end = UILabel()
        end.text = "100"
        end.textColor = .white
        end.numberOfLines = 0
        end.translatesAutoresizingMaskIntoConstraints = false
        end.font = .boldSystemFont(ofSize: 26)
        return end
    }()
    
    private lazy var myScore: UILabel = {
        let sc = UILabel()
        sc.text = "Score: \(score)"
        sc.textColor = .white
        sc.numberOfLines = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.font = .boldSystemFont(ofSize: 26)
        return sc
    }()
    
    private lazy var myRound: UILabel = {
        let rd = UILabel()
        rd.text = "Round: \(round)"
        rd.textColor = .white
        rd.numberOfLines = 0
        rd.translatesAutoresizingMaskIntoConstraints = false
        rd.font = .boldSystemFont(ofSize: 26)
        return rd
    }()
    
    private lazy var mySlider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.tintColor = .green
        slider.thumbTintColor = .red
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setValue(50, animated: true)
        return slider
    }()
    
    private lazy var myButton: UIButton = {
       let button = UIButton()
        button.setTitle("Hit Me!", for: .normal)
        button.backgroundColor = .orange
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var myButtonRepeat: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "repeat"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
       
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        allConstraints()
    }
}


extension ViewController {
    func allConstraints(){
        NSLayoutConstraint.activate([
                        
            myTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            
            myTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            myTitle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            
            mySlider.topAnchor.constraint(equalTo: myTitle.topAnchor, constant: 80),
            
            mySlider.leadingAnchor.constraint(equalTo: myTitle.leadingAnchor, constant: 40),

            mySlider.trailingAnchor.constraint(equalTo: myTitle.trailingAnchor, constant: -40),
            
            
            startOne.leadingAnchor.constraint(equalTo: mySlider.leadingAnchor, constant: -20),
            startOne.topAnchor.constraint(equalTo: mySlider.topAnchor),
            
            endHundred.trailingAnchor.constraint(equalTo: mySlider.trailingAnchor, constant: 50),
            endHundred.topAnchor.constraint(equalTo: mySlider.topAnchor),
            
            myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30),
            myButton.widthAnchor.constraint(equalToConstant: 100),
            
            myScore.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            myScore.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            myRound.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            myRound.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            myButtonRepeat.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myButtonRepeat.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }
}

extension ViewController {
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: buttonTitle, style: .default) { (_) in
            self.continueGame()
        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func getValue(_ sliderValue: UISlider) {
        sliderCurrentValue = Int(sliderValue.value)
    }
    
    @objc func startGame() {
        print("Cureent Random Value: ", currentValue)
        print("Slider Current Value: ", sliderCurrentValue)
        showAlert(title: "Hello baby", message: "shat mots es eli pordi", buttonTitle: "OK")
    }
    
    @objc func clearGame() {
        score = 0
        round = 0
        mySlider.setValue(50, animated: true)
        currentValue = Int.random(in: 1...100)
    }
    
    func continueGame() {
        round += 1
        score += 20
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.currentValue = Int.random(in: 1...100)
        }
    }
}

extension ViewController {
    func setupView() {
        self.view.backgroundColor = .darkGray
        
        self.view.addSubview(myTitle)
        self.view.addSubview(mySlider)
        self.view.addSubview(startOne)
        self.view.addSubview(endHundred)
        self.view.addSubview(myButton)
        self.view.addSubview(myScore)
        self.view.addSubview(myRound)
        self.view.addSubview(myButtonRepeat)
        mySlider.addTarget(self, action: #selector(getValue(_ :)), for: .valueChanged)
        myButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        myButtonRepeat.addTarget(self, action: #selector(clearGame), for: .touchUpInside)
    }
}
