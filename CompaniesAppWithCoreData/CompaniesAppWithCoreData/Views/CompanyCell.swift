//
//  CompanyCell.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 19.07.23.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    var company: CompanyData? {
        didSet {
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
            if let name = company?.name, let founded = company?.founded {
                
                // MMM dd, yyyy
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                            
                let dateString = "\(name) - Founded: \(foundedDateString)"
                
                nameFoundedDateLable.text = dateString
            } else {
                nameFoundedDateLable.text = company?.name
            }
        }
    }
    
    private lazy var companyImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "select_photo_empty"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.darkBlue.cgColor
        img.layer.borderWidth = 1
        return img
    }()
    
    private lazy var nameFoundedDateLable: UILabel = {
       let lable = UILabel()
        lable.text = "Company Text"
        lable.font = .boldSystemFont(ofSize: 18)
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .tealColor
        
        addSubview(companyImageView)
        
        addSubview(nameFoundedDateLable)
        
        NSLayoutConstraint.activate([
            companyImageView.heightAnchor.constraint(equalToConstant: 40),
            companyImageView.widthAnchor.constraint(equalToConstant: 40),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameFoundedDateLable.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8),
            nameFoundedDateLable.topAnchor.constraint(equalTo: topAnchor),
            nameFoundedDateLable.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameFoundedDateLable.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
