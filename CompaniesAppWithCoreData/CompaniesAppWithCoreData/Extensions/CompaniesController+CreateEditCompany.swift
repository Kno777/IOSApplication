//
//  CompaniesController+CreateEditCompany.swift
//  CompaniesAppWithCoreData
//
//  Created by Kno Harutyunyan on 19.07.23.
//

import UIKit

extension CompainesController: CreateCompanyControllerDelegate {
    func didEditCompany(company: CompanyData) {
        // update my companies table View
        let row = companiesData.firstIndex(of: company)
        
        let reloadIndexPath = IndexPath(item: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .automatic)
    }
    
    func didAddCompany(company: CompanyData) {
        // 1 - modify my array
        companiesData.append(company)

        // 2 - insert a new indexPath into tabelView
        let indexPath = IndexPath(item: companiesData.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
