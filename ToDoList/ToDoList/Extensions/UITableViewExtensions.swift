//
//  UITableViewExtensions.swift
//  ToDoList
//
//  Created by Kno Harutyunyan on 15.07.23.
//

import UIKit

extension TodoTableViewController: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = self.todoDates[indexPath.item]
        
        let alert = UIAlertController(title: todo.title, message: todo.description, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoDates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TodoTableViewCell
        
        cell.backgroundColor = .darkGray

        let todo = self.todoDates[indexPath.item]
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(todo.isDone, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)

        cell.accessoryView = switchView
        
        cell.todo = todo
        return cell
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        let rowIndex = sender.tag
        let todo = todoDates[rowIndex]
        todo.isDone = sender.isOn
        
        self.delegate = self
        
        self.delegate?.didTodoDone(isDone: todo.isDone, index: rowIndex)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let noTodo = UILabel()
        noTodo.text = "No Available Todo..."
        noTodo.textColor = .black
        noTodo.textAlignment = .center
        noTodo.font = .boldSystemFont(ofSize: 18)
        return noTodo
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.todoDates.count == 0 ? 150 : 0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            let company = self.todoDates[indexPath.item]
            print("Attempting to delete company:", company.title )
            
            // remove the company from our tableView
            self.todoDates.remove(at: indexPath.item)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
  
        // Create a UIContextualAction for edit
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completionHandler) in
            
            let todo = self.todoDates[indexPath.item]
            
            print("Attempting to edit company:", todo.title)
            
            let editCompanyController = AddTodoViewController()
            editCompanyController.delegate = self
            editCompanyController.todo = todo

            let navigationController = UINavigationController(rootViewController: editCompanyController)
            
            if let sheet = navigationController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            
            self.present(navigationController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .gray
        
        // Create a UISwipeActionsConfiguration with the actions
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return swipeConfiguration
    }
}
