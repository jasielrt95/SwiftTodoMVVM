//
//  TaskDetailView.swift
//  SwiftToDo
//
//  Created by Jasiel Rivera Trinidad on 12/5/24.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TaskViewModel
    let taskId: UUID
    @State private var editedTitle: String = ""
    @State private var isCompleted: Bool = false
    @State private var showingSaveAlert = false
    
    init(viewModel: TaskViewModel, taskId: UUID) {
        self.viewModel = viewModel
        self.taskId = taskId
        if let task = viewModel.tasks.first(where: { $0.id == taskId }) {
            _editedTitle = State(initialValue: task.title)
            _isCompleted = State(initialValue: task.isCompleted)
        }
    }
    
    var body: some View {
        Form {
            TextField("Task Title", text: $editedTitle)
                .accessibilityLabel("Edit Task Title")
            
            Toggle("Completed", isOn: $isCompleted)
                .accessibilityLabel("Task Completion Toggle")
            
            if let task = viewModel.tasks.first(where: { $0.id == taskId }) {
                Section {
                    Text("Created: \(task.createdAt.formatted())")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Task Details")
        .navigationBarItems(trailing: Button("Save") {
            viewModel.updateTask(id: taskId, title: editedTitle, isCompleted: isCompleted)
            showingSaveAlert = true
        })
        .alert("Changes Saved", isPresented: $showingSaveAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your changes have been saved successfully.")
        }
    }
}
