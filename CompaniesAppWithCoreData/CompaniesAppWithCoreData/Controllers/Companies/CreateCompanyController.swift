//
//  CreateCompanyController.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 17.07.23.
//

import UIKit
import CoreData

class CreateCompanyController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    weak var delegate: CreateCompanyControllerDelegate?
    
    var company: CompanyData? {
        didSet {
            nameTextField.text = company?.name
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
                setupCircularImageStyle()
            }
            
            guard let founded = company?.founded else { return }
            
            datePicker.date = founded
        }
    }
    
    private lazy var companyImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "select_photo_empty"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true // remember to do this, otherwise image views by default are not interactive
        img.contentMode = .scaleAspectFill
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelSelectPhoto)))
        return img
    }()
    
    private lazy var nameLable: UILabel = {
       let lable = UILabel()
        lable.text = "Name"
        // enable autoLayout
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter a name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
       let dp = UIDatePicker()
        dp.preferredDatePickerStyle = .wheels
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        setupNavigationButtons()
        setupNavigationStyle()
        setupUI()
    }
    
    private func setupCircularImageStyle() {
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
        companyImageView.layer.borderWidth = 2
        companyImageView.layer.borderColor = UIColor.darkBlue.cgColor
    }
    
    private func setupNavigationButtons() {
        setupCancelButtonInNavBar(selector: #selector(handleCancel))
        setupSaveButtonInNavBar(selector: #selector(handleSave))
    }
    
    private func setupUI() {
        
        let lightBlueBackgroundView = setupLightBlueBackgroundView(height: 350)
        
        self.view.addSubview(nameLable)
        
        self.view.addSubview(nameTextField)
        
        self.view.addSubview(datePicker)
        
        self.view.addSubview(companyImageView)
        
        NSLayoutConstraint.activate([
            
            companyImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            companyImageView.heightAnchor.constraint(equalToConstant: 100),
            companyImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            companyImageView.widthAnchor.constraint(equalToConstant: 100),
            
            
            nameLable.topAnchor.constraint(equalTo: companyImageView.bottomAnchor),
            nameLable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLable.widthAnchor.constraint(equalToConstant: 100),
            nameLable.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.topAnchor.constraint(equalTo: nameLable.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLable.trailingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLable.bottomAnchor),
            
            // setup the date picker view
            datePicker.topAnchor.constraint(equalTo: nameLable.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: lightBlueBackgroundView.bottomAnchor),
        ])
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleSave() {
        if company == nil {
            createCompany()
        } else {
            editCompany()
        }
    }
    
    @objc func handelSelectPhoto() {
        print("add")
        
        let imagePickerController = UIImagePickerController()
    
        imagePickerController.delegate = self
        
        imagePickerController.allowsEditing = true
        
        imagePickerController.modalPresentationStyle = .fullScreen
        
        present(imagePickerController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            companyImageView.image = editedImage
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            companyImageView.image = originalImage
        }
        
        setupCircularImageStyle()
        
        dismiss(animated: true)
    }
    
    private func editCompany() {
        let context = CoreDataManager.shared.presistentContainer.viewContext
        
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company?.imageData = imageData
        }
        
        do {
            try context.save()
            
            // save successfuly
            dismiss(animated: true) {
                self.delegate?.didEditCompany(company: self.company!)
            }
            
        } catch {
            fatalError("I can't save changes: \(error)")
        }
    }
    
    private func createCompany() {
        let context = CoreDataManager.shared.presistentContainer.viewContext
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "CompanyData", into: context)
        
        company.setValue(self.nameTextField.text, forKey: "name")
        company.setValue(self.datePicker.date, forKey: "founded")
        
        if let companyImage = companyImageView.image {
            let imageData = companyImage.jpegData(compressionQuality: 0.8)
            company.setValue(imageData, forKey: "imageData")
        }
        
        // preform the save
        
        do {
            try context.save()
            
            // success
            dismiss(animated: true) {   
                self.delegate?.didAddCompany(company: company as! CompanyData)
            }
        } catch {
            fatalError("I can't save data: \(error)")
        }
    }
}
