//
//  Todo.swift
//  MvvmTodo
//
//  Created by 김원태 on 3/6/25.
//

import Foundation

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
