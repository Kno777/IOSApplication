//
//  CreateCompanyControllerDelegate+Protocol.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 17.07.23.
//

import UIKit
 
// Custom Delegation

protocol CreateCompanyControllerDelegate: AnyObject {
    func didAddCompany(company: CompanyData)
    func didEditCompany(company: CompanyData)
}
