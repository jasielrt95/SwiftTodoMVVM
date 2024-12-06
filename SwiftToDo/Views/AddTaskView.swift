//
//  AddTaskView.swift
//  SwiftToDo
//
//  Created by Jasiel Rivera Trinidad on 12/5/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State private var taskTitle = ""
    @State private var showingValidationAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $taskTitle)
                    .accessibilityLabel("Task Title Input")
            }
            .navigationTitle("New Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    if taskTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                        showingValidationAlert = true
                    } else {
                        viewModel.addTask(taskTitle)
                        dismiss()
                    }
                }
            )
            .alert("Invalid Task", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Task title cannot be empty")
            }
        }
    }
}
