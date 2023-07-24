//
//  CreateEmployeeController.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 21.07.23.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    var company: CompanyData?
    
    weak var delegate: CreateEmployeeControllerDelegate?
    
    private lazy var nameLable: UILabel = {
       let lable = UILabel()
        lable.text = "Name"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var birtdayLable: UILabel = {
       let lable = UILabel()
        lable.text = "Birthday"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter a name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var birthdayTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "MM/DD/YYYY"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var employeeTypeSegementController: UISegmentedControl = {
        
        let types = [
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagement.rawValue,
            EmployeeType.Staff.rawValue
        ]
        
       let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        sc.selectedSegmentTintColor = .darkBlue
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        navigationItem.title = "Create Employee"
        
        setupCancelButtonInNavBar(selector: #selector(handelCancel))
        
        setupSaveButtonInNavBar(selector: #selector(handelSave))
        
        setupNavigationStyle()
                
        setupUI()
    }
    
    @objc private func handelCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handelSave() {
        guard let employeeName = nameTextField.text else { return }
        guard let company = self.company else { return }
        guard let birthdayText = birthdayTextField.text else { return }
        
        // let's preform validation step here
        if birthdayText.isEmpty {
            let alertController = UIAlertController(title: "Empty Birthday", message: "You have not entered a birthday.", preferredStyle: .alert)
            present(alertController, animated: true)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            return
        }
        
        guard let employeeType = employeeTypeSegementController.titleForSegment(at: employeeTypeSegementController.selectedSegmentIndex) else { return }
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
            let alertController = UIAlertController(title: "Bad Date", message: "Birthday date entered not valid", preferredStyle: .alert)
            present(alertController, animated: true)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            return
        }
        
        let (employee, error) = CoreDataManager.shared.createEmployee(employeeName: employeeName, company: company, birthday: birthdayDate, employeeType: employeeType)
        
        if let error = error {
            // is where you present an error modal of some kind
            // perhaps use a UIAlertController to show your error
            print("XXXXXXX", error)
        } else {
            
            // creation success
            dismiss(animated: true) {
                // we'll call the delegate shomhow
                self.delegate?.didAddEmployee(employee: employee!)
            }
        }
    }
    
    private func setupUI() {
        
        _ = setupLightBlueBackgroundView(height: 150)

        
        view.addSubview(nameLable)
        
        view.addSubview(nameTextField)
        
        view.addSubview(birtdayLable)
        
        view.addSubview(birthdayTextField)
        
        view.addSubview(employeeTypeSegementController)
        
        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLable.widthAnchor.constraint(equalToConstant: 100),
            nameLable.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.topAnchor.constraint(equalTo: nameLable.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLable.trailingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLable.bottomAnchor),
            
            birtdayLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor),
            birtdayLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            birtdayLable.widthAnchor.constraint(equalToConstant: 100),
            birtdayLable.heightAnchor.constraint(equalToConstant: 50),
            
            birthdayTextField.topAnchor.constraint(equalTo: nameLable.bottomAnchor),
            birthdayTextField.leadingAnchor.constraint(equalTo: birtdayLable.trailingAnchor),
            birthdayTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            birthdayTextField.bottomAnchor.constraint(equalTo: birtdayLable.bottomAnchor),
            
            employeeTypeSegementController.topAnchor.constraint(equalTo: birtdayLable.bottomAnchor),
            employeeTypeSegementController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            employeeTypeSegementController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            employeeTypeSegementController.heightAnchor.constraint(equalToConstant: 34),
        ])
    }
}
