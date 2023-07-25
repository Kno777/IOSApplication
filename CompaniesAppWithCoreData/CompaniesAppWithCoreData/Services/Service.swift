//
//  Service.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 25.07.23.
//

import Foundation
import CoreData

struct Service {
    
    static let shared = Service()
    
    let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func downloadCompaniesFromServer() {
        print("Attempting to download companies.")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            
            print("Finished downloading...")
            
            if let err = err {
                print("Failed to download companies: ", err)
                return
            }
            
            guard let data = data else { return }
                        
            let jsonDecoder = JSONDecoder()
            
            do {
                let jsonCompanies = try jsonDecoder.decode([CompanyModel].self, from: data)
                
                let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                
                privateContext.parent = CoreDataManager.shared.presistentContainer.viewContext
                
                
                jsonCompanies.forEach { jsonCompany in
                    print(jsonCompany.name)
                    
                    let company = CompanyData(context: privateContext)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    let foundedDate = dateFormatter.date(from: jsonCompany.founded ?? "03/01/2003")
                    
                    
                    company.name = jsonCompany.name
                    company.founded = foundedDate
                    
                    
                    jsonCompany.employees?.forEach { jsonEmployee in
                        print(jsonEmployee.type)
                        
                        let employee = Employee(context: privateContext)
                        employee.name = jsonEmployee.name
                        employee.type = jsonEmployee.type
                        
                        let employeeInformation = EmployeeInformation(context: privateContext)
                        let birthdayDate = dateFormatter.date(from: jsonEmployee.birthday)
                        employeeInformation.birthday = birthdayDate
                        
                        employee.employeeInformation = employeeInformation
                        
                        employee.companyData = company
                    }
                    
                    do {
                        try privateContext.save()
                        try privateContext.parent?.save()
                    } catch {
                        print("Failed to save private context")
                    }
                }
                
            } catch {
                print("Failed to deconde companies data.", error)
            }
            
            //let string = String(data: data, encoding: .utf8)
            //print(string)
            
            
            
        }.resume() // please don't forget to call this resume method
    }
}
