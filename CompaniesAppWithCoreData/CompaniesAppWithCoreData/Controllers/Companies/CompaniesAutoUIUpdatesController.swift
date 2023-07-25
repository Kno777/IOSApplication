//
//  CompaniesAutoUIUpdatesController.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 25.07.23.
//

import UIKit
import CoreData

class CompaniesAutoUIUpdatesController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // warning: this code here is going to be a bit of monster
    
    private lazy var fetchedResultsController: NSFetchedResultsController = {
        
       let result: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
       let context = CoreDataManager.shared.presistentContainer.viewContext
        
        result.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
       let frc = NSFetchedResultsController(fetchRequest: result, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
        
        do {
             try frc.performFetch()
        } catch {
            print("Failed to fetch: ", error)
        }
        
        frc.delegate = self
        
        return frc
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationStyle()
                        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handelAdd)),
            UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(handelDelete)),
        ]
        
        navigationItem.title = "Companies Auto Updates"
        
        tableView.backgroundColor = .darkBlue
        tableView.sectionHeaderTopPadding = 0
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        
        //fetchedResultsController.fetchedObjects?.forEach({ company in
        //    print(company.name ?? "")
        //})
        
        //let service = Service()
        //service.downloadCompaniesFromServer()
        
        //Service.shared.downloadCompaniesFromServer()
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(handelRefresh), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    @objc private func handelRefresh() {
        Service.shared.downloadCompaniesFromServer()
        self.refreshControl?.endRefreshing()
    }
    
    @objc private func handelDelete() {
        print("deletee")
        
        let request: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
        
        // request.predicate = NSPredicate(format: "name CONTAINS %@", "B")
        
        let context = CoreDataManager.shared.presistentContainer.viewContext
        
        do {
            let companiesWithB = try context.fetch(request)
            
            companiesWithB.forEach { company in
                print("delete: ", company.name ?? "")
                context.delete(company)
            }
            
            try context.save()
            
        } catch {
            print(error)
        }
    }
    
    @objc private func handelAdd() {
        print("adddddd")
        
        let context = CoreDataManager.shared.presistentContainer.viewContext
        
        let company = CompanyData(context: context)
        
        company.name = "BMW"
        
        try? context.save()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
     
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError("@unknown")
        }
    }
     
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            fatalError("@unknown")
        }
    }
     
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let lable = IntendedLableForSection()
        lable.text = fetchedResultsController.sections?[section].name
        lable.backgroundColor = .lightBlue
        return lable
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyCell
        
        let company = fetchedResultsController.object(at: indexPath)
        
        cell.company = company
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeesListController = EmployeesController()
        employeesListController.company = fetchedResultsController.object(at: indexPath)
        
        navigationController?.pushViewController(employeesListController, animated: true)
    }
}
