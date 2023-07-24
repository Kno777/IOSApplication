//
//  CreateEditTodoControllerDelegate+Protocols.swift
//  ToDoList
//
//  Created by Kno Harutyunyan on 20.07.23.
//

import UIKit

protocol CreateTodoViewControllerDelegate: AnyObject {
    func didAddTodo(_ controller: AddTodoViewController, todo: ToDo)
    
    func didEditTodo(_ controller: AddTodoViewController, todo: ToDo)
    
    func didTodoDone(isDone: Bool, index: Int)
}
