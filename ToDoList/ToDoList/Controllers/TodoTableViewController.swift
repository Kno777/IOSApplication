//
//  TodoTableViewController.swift
//  ToDoList
//
//  Created by Kno Harutyunyan on 15.07.23.
//

import UIKit

class TodoTableViewController: UIViewController, CreateTodoViewControllerDelegate {
    
    weak var delegate: CreateTodoViewControllerDelegate?
    
    func didTodoDone(isDone: Bool, index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func didEditTodo(_ controller: AddTodoViewController, todo: ToDo){
        
        guard let index = todoDates.firstIndex(where: { $0 === controller.todo }) else {
            return // Handle the case when the todo object is not found in the array
        }
        todoDates[index] = todo
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func didAddTodo(_ controller: AddTodoViewController, todo: ToDo) {
        self.todoDates.append(todo)
        
        let indexPath = IndexPath(item: todoDates.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    var todoDates: [ToDo] = []
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .darkGray
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAppBar()
    }
    
    func setupTableView() {
        self.navigationItem.titleView?.tintColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "cellId")


        view.addSubview(tableView)

        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func setupAppBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(didOpenAddSheet))
        
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.navigationController?.navigationBar.topItem?.title = "Todo List"
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func didOpenAddSheet() {
        let viewControllerToPresent = AddTodoViewController()
        viewControllerToPresent.delegate = self
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)

        viewControllerToPresent.title = "Add Todo"
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        present(navigationController, animated: true, completion: nil)
    }
}
