//
//  EmployeesController.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 21.07.23.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    
    func didAddEmployee(employee: Employee) {
//        fetchEmployees()
//        tableView.reloadData()
        
        guard let section = employeeTypes.firstIndex(of: employee.type!) else { return }
        
        let item = allEmployees[section].count
        
        let insertionIndexPath = IndexPath(item: item, section: section)
        
        allEmployees[section].append(employee)
        
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
    }
    
    var company: CompanyData?
    
    var employees: [Employee] = []
    
    var allEmployees: [[Employee]] = []
    
    let employeeTypes = [
        EmployeeType.Executive.rawValue,
        EmployeeType.SeniorManagement.rawValue,
        EmployeeType.Staff.rawValue,
    ]

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkBlue
        
        fetchEmployees()
        
        setupPlusButtonInNavBar(selector: #selector(handelAdd))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.sectionHeaderTopPadding = 0
    }
    
    private func fetchEmployees() {
        
        guard let companyEmployees = self.company?.employee?.allObjects as? [Employee] else { return }
        
        // let's filter employees for "Executive"
        let executive = companyEmployees.filter { employee in
            return employee.type == EmployeeType.Executive.rawValue
        }
        
        let seniorManagement = companyEmployees.filter { $0.type == EmployeeType.SeniorManagement.rawValue}
        
        let staff = companyEmployees.filter { $0.type == EmployeeType.Staff.rawValue}
        
        allEmployees = [
            executive,
            seniorManagement,
            staff
        ]
    }
    
    @objc private func handelAdd() {
        if let companyName = navigationItem.title {
            print("Adding a new employee under this company: ", companyName)
        }
        
        let createEmployeeController = CreateEmployeeController()
        
        let navController = CustomNavigationController(rootViewController: createEmployeeController)
        
        createEmployeeController.delegate = self
        createEmployeeController.company = company
        
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    let cellId = "celllllllllId"
}

extension EmployeesController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let employee = allEmployees[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = employee.name
        
        if let birthday = employee.employeeInformation?.birthday {
            cell.textLabel?.text = "\(employee.name ?? "")    \(birthday.formatted(date: .abbreviated, time: .omitted))"
        }
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .tealColor
        cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lable = IntendedLableForSection()
        
        switch section {
        case 0:
            lable.text = EmployeeType.Executive.rawValue
        case 1:
            lable.text = EmployeeType.SeniorManagement.rawValue
        default:
            lable.text = EmployeeType.Staff.rawValue
        }
        lable.backgroundColor = .lightBlue
        lable.textColor = .darkBlue
        lable.font = .boldSystemFont(ofSize: 16)
        return lable
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
}
