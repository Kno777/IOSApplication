//
//  CompaniesControllerExtensionFor+TableView.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 18.07.23.
//

import UIKit

extension CompainesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let company = self.companiesData[indexPath.item]
        
        let employeesController = EmployeesController()
        
        employeesController.company = company
        
        navigationController?.pushViewController(employeesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            let company = self.companiesData[indexPath.item]
            print("Attempting to delete company:", company.name ?? "")
            
            // remove the company from our tableView
            self.companiesData.remove(at: indexPath.item)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // remove the company from our Core Data
            
            let context = CoreDataManager.shared.presistentContainer.viewContext
            
            context.delete(company)
            
            do {
                try context.save()
            } catch let delErr {
                fatalError("Failed to delete company from Core Data: \(delErr)")
            }
            
            completionHandler(true)
        }
        
  
        // Create a UIContextualAction for edit
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completionHandler) in
            let company = self.companiesData[indexPath.item]
            print("Attempting to edit company:", company.name ?? "")
            // Perform the edit action here
            
            let editCompanyController = CreateCompanyController()
            editCompanyController.delegate = self
            editCompanyController.company = self.companiesData[indexPath.item]
            
            let navigationController = CustomNavigationController(rootViewController: editCompanyController)
            
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .lightRed
        editAction.backgroundColor = .darkBlue
        
        // Create a UISwipeActionsConfiguration with the actions
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companiesData.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CompanyCell
        
        let company = companiesData[indexPath.item]
        cell.company = company
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companiesData.count
    }
}
