//
//  CreateEmployeeController+Protocols.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 21.07.23.
//

import UIKit

protocol CreateEmployeeControllerDelegate: AnyObject {
    func didAddEmployee(employee: Employee)
}
