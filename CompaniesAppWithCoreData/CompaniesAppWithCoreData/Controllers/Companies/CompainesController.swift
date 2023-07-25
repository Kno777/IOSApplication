//
//  ViewController.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 17.07.23.
//

import UIKit
import CoreData

class CompainesController: UITableViewController {
    
    var companiesData: [CompanyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
        
        self.view.backgroundColor = .white
        
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.sectionHeaderTopPadding = 0
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellId")
        
        navigationItem.title = "Compaines"
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset)),
            
//            UIBarButtonItem(title: "Nested Updates", style: .plain, target: self, action: #selector(doNestedUpdates))
        ]
        
        setupNavigationStyle()
        
    }
    
    @objc private func doNestedUpdates() {
        print("Trying to preform nested updates now...")
        
        DispatchQueue.global(qos: .background).async {
            // we'll try to preform our updates
            
            // we'll first coustruct a custom MOC
            
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            
            privateContext.parent = CoreDataManager.shared.presistentContainer.viewContext
            
            // execute updates on privateContext now
            
            let request: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
            request.fetchLimit = 2
            
            do {
                let companies = try privateContext.fetch(request)
                
                companies.forEach { company in
                    print(company.name ?? "")
                    company.name = "K: \(company.name ?? "")"
                }
                
                do {
                    try privateContext.save()
                    
                    // after save succeeds
                    
                    DispatchQueue.main.async {
                        do {
                            let context = CoreDataManager.shared.presistentContainer.viewContext
                            
                            if context.hasChanges {
                                try context.save()
                            }
                            
                            self.tableView.reloadData()
                            
                        } catch {
                            print("Failed to preform save on main context")
                        }
                    }
                    
                } catch {
                    print("Failed to preform save on private context")
                }
                
            } catch {
                print("Failed to fetch on private context.")
            }
            
        }
    }
    
    @objc private func doUpdates() {
        print("Trying to updates core data companies.")
        
        
        CoreDataManager.shared.presistentContainer.performBackgroundTask { backgroundContext in
            
            let request: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
            
            do {
                let companies = try backgroundContext.fetch(request)
                
                companies.forEach { company in
                    print(company.name ?? "")
                    company.name = "D: \(company.name ?? "")"
                }
                
                do {
                    try backgroundContext.save()
                    
                    // let's try tu update UI after save
                    
                    DispatchQueue.main.async {
                        CoreDataManager.shared.presistentContainer.viewContext.reset()
                        self.fetchCompanies()
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("Failed to save changes on background")
                }
                
            } catch {
                print("Failed to fetch companies on background")
            }
        }
    }
    
    @objc private func doWork() {
        print("do work")
        
        CoreDataManager.shared.presistentContainer.performBackgroundTask { backgroundContext in

            (0...5).forEach { value in
                let company = CompanyData(context: backgroundContext)
                company.name = String(value)
            }

            do {
                try backgroundContext.save()
                
                DispatchQueue.main.async {
                    self.fetchCompanies()
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Failed to save company on a background thread...")
            }
        }

        // GCD - Grand Central Dispatch

        DispatchQueue.global(qos: .background).async {
            // creating some Company objects on a background thread

            //let context = CoreDataManager.shared.presistentContainer.viewContext
        }

    }
    
    @objc func handleReset() {
        let context = CoreDataManager.shared.presistentContainer.viewContext
        
        let betchDeleteRequest = NSBatchDeleteRequest(fetchRequest: CompanyData.fetchRequest())
        
        do {
          try context.execute(betchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            
            for (index, _) in companiesData.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            companiesData.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
            
        } catch {
            fatalError("Failed to delete all Company Data: \(error)")
        }
    }
    
    @objc func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        let navigationController = CustomNavigationController(rootViewController: createCompanyController)
        
        createCompanyController.delegate = self
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    private func fetchCompanies() {
        // attemt my Core Data fetch somehow..
        
        let context = CoreDataManager.shared.presistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CompanyData>(entityName: "CompanyData")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            companies.forEach { company in
                print(company.name ?? "nil")
            }
            
            self.companiesData = companies
            self.tableView.reloadData()
            
        } catch {
            fatalError("Request Failed reson is: \(error)")
        }
    }
}

