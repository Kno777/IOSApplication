//
//  CoreDataManager.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 18.07.23.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager() // will live forever as long as your application is still alive, it's properties will too
    
    let presistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CompanyDataModels")
        container.loadPersistentStores { storeDescription, err in
            if let err = err {
                fatalError("Loading of store is failed: \(err)")
            }
        }
        return container
    }()
    
    func createEmployee(employeeName: String, company: CompanyData, birthday: Date, employeeType: String) -> (Employee?, Error?) {
        let context = presistentContainer.viewContext
        // create an employee
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        
        employee.companyData = company
        employee.type = employeeType
        
        employee.setValue(employeeName, forKey: "name")
        
        employeeInformation.taxId = "456"
        employeeInformation.birthday = birthday
        
        //employeeInformation.setValue("456", forKey: "taxId")
        
        employee.employeeInformation = employeeInformation
        
        do {
            try context.save()
            
            // save successfuly
            return (employee, nil)
        } catch {
            print("Cannot create an employee: ", error)
            return (nil, error)
        }
    }
    
    
}
