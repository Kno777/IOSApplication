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
            
            UIBarButtonItem(title: "Do Work", style: .plain, target: self, action: #selector(doWork))
        ]
        
        setupNavigationStyle()
        
    }
    
    @objc private func doWork() {
        print("do work")
        
//        CoreDataManager.shared.presistentContainer.performBackgroundTask { backgroundContext in
//
//            (0...100).forEach { value in
//                let company = CompanyData(context: backgroundContext)
//                company.name = String(value)
//            }
//
//            do {
//                try backgroundContext.save()
//            } catch {
//                print("Failed to save company on a background thread...")
//            }
//        }
//
//        // GCD - Grand Central Dispatch
//
//        DispatchQueue.global(qos: .background).async {
//            // creating some Company objects on a background thread
//
//            //let context = CoreDataManager.shared.presistentContainer.viewContext
//        }
        
        DispatchQueue.global(qos: .userInteractive).sync {
            print("ssss")
        }
        
        DispatchQueue.main.async {
            print("aaaaa")
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

