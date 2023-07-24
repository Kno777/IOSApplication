//
//  todo.swift
//  ToDoList
//
//  Created by Kno Harutyunyan on 15.07.23.
//

class ToDo{
    var title: String
    var description: String
    var isDone: Bool = false
    
    init(title: String, description: String, isDone: Bool = false) {
        self.title = title
        self.description = description
        self.isDone = isDone
    }
}
