//
//  TodoView.swift
//  MvvmTodo
//
//  Created by 김원태 on 3/6/25.
//

import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel() // ViewModel을 상태로 관리

    @State private var newTodoTitle: String = "" // 새로운 할 일을 위한 텍스트 입력 필드

    var body: some View {
        NavigationView {
            VStack {
                // 할 일 추가 입력 필드
                HStack {
                    TextField("할 일을 입력하세요", text: $newTodoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        if !newTodoTitle.isEmpty {
                            viewModel.addTodo(title: newTodoTitle)
                            newTodoTitle = "" // 입력 필드 초기화
                        }
                    }) {
                        Text("추가")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                // 할 일 목록을 표시하는 List
                List {
                    ForEach(viewModel.todos) { todo in
                        HStack {
                            Text(todo.title)
                                .strikethrough(todo.isCompleted, color: .gray)
                            Spacer()
                            if todo.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                            }
                        }
                        .contentShape(Rectangle()) // 클릭 영역 확장
                        .onTapGesture {
                            if let index = viewModel.todos.firstIndex(where: { $0.id == todo.id }) {
                                viewModel.toggleComplete(at: index)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("할 일 목록")
            .navigationBarItems(trailing: EditButton())
        }
    }

    // 삭제 메서드
    private func deleteItems(at offsets: IndexSet) {
        viewModel.todos.remove(atOffsets: offsets)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
