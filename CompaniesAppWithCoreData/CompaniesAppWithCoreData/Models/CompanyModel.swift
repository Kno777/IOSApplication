//
//  CompanyModel.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 25.07.23.
//

import Foundation

struct CompanyModel: Decodable {
    let name: String
    let founded: String?
    var employees: [EmployeeModel]?
}
