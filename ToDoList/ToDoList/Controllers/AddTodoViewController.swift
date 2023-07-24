//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Kno Harutyunyan on 15.07.23.
//

import Foundation
import UIKit

class AddTodoViewController: UIViewController {
    
    weak var delegate: CreateTodoViewControllerDelegate?
    
    var todo: ToDo? {
        didSet {
            sheetTitleTextField.text = todo?.title
            sheetDescriptionTextField.text = todo?.description
        }
    }
    
    private lazy var sheetView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var sheetStackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private lazy var sheetTitleTextField: UITextField = {
       let title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .boldSystemFont(ofSize: 18)
        title.textColor = .black
        title.returnKeyType = .next
        title.delegate = self
        title.attributedPlaceholder = NSAttributedString(string: "Enter a title",attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        return title
    }()
    
    private lazy var sheetDescriptionTextField: UITextField = {
       let title = UITextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .boldSystemFont(ofSize: 18)
        title.textColor = .black
        title.returnKeyType = .done
        title.delegate = self
        title.attributedPlaceholder = NSAttributedString(string: "Enter a description",attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        return title
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = self.todo == nil ? "Create Todo" : "Edit Todo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.addSubview(sheetView)
        sheetView.addSubview(sheetStackView)
        sheetStackView.addArrangedSubview(sheetTitleTextField)
        sheetStackView.addArrangedSubview(sheetDescriptionTextField)
        setupConstraints()
        setupNavigationBarForSheet()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            sheetView.heightAnchor.constraint(equalToConstant: 200),
            
            
            sheetStackView.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 10),
            sheetStackView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 10),

            sheetStackView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -10),
            
            sheetTitleTextField.topAnchor.constraint(equalTo: sheetStackView.topAnchor),
            sheetTitleTextField.leadingAnchor.constraint(equalTo: sheetStackView.leadingAnchor),
            sheetTitleTextField.trailingAnchor.constraint(equalTo: sheetStackView.trailingAnchor),

            sheetDescriptionTextField.topAnchor.constraint(equalTo: sheetTitleTextField.topAnchor, constant: 80),
            sheetDescriptionTextField.leadingAnchor.constraint(equalTo: sheetStackView.leadingAnchor),
            sheetDescriptionTextField.trailingAnchor.constraint(equalTo: sheetStackView.trailingAnchor),
        ])
    }
    
    func setupNavigationBarForSheet() {
        self.view.backgroundColor = .gray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(closeSheet))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handelSave))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func closeSheet() {
        dismiss(animated: true)
    }
    
    @objc func handelSave() {
        if todo == nil {
            createTodo()
        } else {
            editTodo()
        }
    }
    
    private func editTodo() {
        guard let todo = self.todo else {
            return // Ensure that the todo object is not nil
        }
        
        let updatedTitle = sheetTitleTextField.text ?? ""
        let updatedDescription = sheetDescriptionTextField.text ?? ""
        
        let updatedTodo = ToDo(title: updatedTitle, description: updatedDescription, isDone: todo.isDone)
        
        self.delegate?.didEditTodo(self, todo: updatedTodo)
        dismiss(animated: true)
    }
    
    private func createTodo() {
        let title = sheetTitleTextField.text ?? ""
        let description = sheetDescriptionTextField.text ?? ""
        
        self.todo = ToDo(title: title, description: description)

        dismiss(animated: true) {
            self.delegate?.didAddTodo(self, todo: self.todo!)
        }
    }
}


extension AddTodoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == sheetTitleTextField {
            sheetDescriptionTextField.becomeFirstResponder()
            // Move focus to the next text field
        } else {
            sheetTitleTextField.resignFirstResponder()
            // Hide the keyboard
            // Perform the desired action when the "Next" button is pressed on the last text field
            // Your code here...
        }
        textField.resignFirstResponder()
    
        return true
    }
}
