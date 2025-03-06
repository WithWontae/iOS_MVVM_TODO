//
//  TodoViewModel.swift
//  MvvmTodo
//
//  Created by 김원태 on 3/6/25.
//

import Foundation
import Combine

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = [] // Combine으로 바인딩

    func addTodo(title: String) {
        let newTodo = Todo(title: title)
        todos.append(newTodo)
    }

    func deleteTodo(at index: Int) {
        guard index >= 0 && index < todos.count else { return }
        todos.remove(at: index)
    }

    func toggleComplete(at index: Int) {
        guard index >= 0 && index < todos.count else { return }
        todos[index].isCompleted.toggle()
    }
}
