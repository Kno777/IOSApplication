//
//  EmployeeModel.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 25.07.23.
//

import Foundation

struct EmployeeModel: Decodable {
    let name: String
    let type: String
    let birthday: String
}
