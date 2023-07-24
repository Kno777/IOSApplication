//
//  TeamTableViewCell.swift
//  FootballChannel
//
//  Created by Kno Harutyunyan on 07.07.23.
//

import UIKit

protocol TeamTableViewCellDelegate: AnyObject {
    func didTapPlayback(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    static let cellId: String = "TeamTableViewCell"
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var stackView: UIStackView = {
       let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 4
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var badgeImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var playBottom: UIButton = {
        let pb = UIButton()
        pb.translatesAutoresizingMaskIntoConstraints = false
        pb.tintColor = .white
        return pb
    }()
    
    private lazy var nameLable: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 10, weight: .bold)
        return lb
    }()
    
    private lazy var foundedLable: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 12, weight: .light)
        return lb
    }()
    
    private lazy var jobLable: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 10, weight: .light)
        return lb
    }()
    
    private lazy var infoLable: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 12, weight: .medium)
        return lb
    }()
    
    private lazy var footballSccoreIcon: UIImageView = {
       let fs = UIImageView()
        fs.translatesAutoresizingMaskIntoConstraints = false
        fs.contentMode = .scaleAspectFit
        return fs
    }()
    
    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
        self.delegate = nil
        self.containerView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configure(_ item: Team, delegate: TeamTableViewCellDelegate) {
        
        self.delegate = delegate
        self.team = item
        
        
        playBottom.addTarget(self, action: #selector(didTapPlayBack), for: .touchUpInside)
        
        containerView.backgroundColor = item.id.background
        
        badgeImageView.image = item.id.badge
        
        playBottom.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal)
        
        footballSccoreIcon.image = item.id.players
        
        nameLable.text = item.name
        foundedLable.text = item.founded
        jobLable.text = item.manager.name
        infoLable.text = item.info
        
        self.contentView.addSubview(containerView)
        
        
        containerView.addSubview(stackView)
        containerView.addSubview(badgeImageView)
        containerView.addSubview(playBottom)
        containerView.addSubview(footballSccoreIcon)
        
        stackView.addArrangedSubview(nameLable)
        stackView.addArrangedSubview(foundedLable)
        stackView.addArrangedSubview(jobLable)
        stackView.addArrangedSubview(infoLable)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            badgeImageView.heightAnchor.constraint(equalToConstant: 50),
            badgeImageView.widthAnchor.constraint(equalToConstant: 50),
            
            badgeImageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            badgeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: badgeImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: playBottom.leadingAnchor, constant: -8),

            playBottom.heightAnchor.constraint(equalToConstant: 50),
            playBottom.widthAnchor.constraint(equalToConstant: 50),
            
            playBottom.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            playBottom.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            footballSccoreIcon.heightAnchor.constraint(equalToConstant: 50),
            footballSccoreIcon.widthAnchor.constraint(equalToConstant: 50),
            
            footballSccoreIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            footballSccoreIcon.topAnchor.constraint(equalTo: badgeImageView.bottomAnchor, constant: 12)
            
//            stackView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8),
//            stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -8),
//            stackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
//            stackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8),
        ])
    }
    
    @objc func didTapPlayBack(){
        if let team = team {
            delegate?.didTapPlayback(for: team)
        }
    }
}

extension TeamTableViewCell {
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
