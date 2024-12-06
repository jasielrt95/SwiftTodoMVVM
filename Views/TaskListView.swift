//
//  TaskListView.swift
//  SwiftToDo
//
//  Created by Jasiel Rivera Trinidad on 12/5/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var showingProfile = false
    @State private var showingDeleteAlert = false
    @State private var taskToDelete: IndexSet?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    NavigationLink(
                        destination: TaskDetailView(viewModel: viewModel, taskId: task.id)
                    ) {
                        TaskRowView(task: task) {
                            withAnimation {
                                viewModel.toggleTaskCompletion(task)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    taskToDelete = indexSet
                    showingDeleteAlert = true
                }
                .onMove(perform: viewModel.moveTask)
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingProfile.toggle() }) {
                        Image(systemName: "person.circle")
                            .accessibilityLabel("Profile")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask.toggle() }) {
                        Image(systemName: "plus")
                            .accessibilityLabel("Add Task")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingProfile) {
                ProfileView()
            }
            .alert("Delete Task?", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let indexSet = taskToDelete {
                        viewModel.deleteTask(at: indexSet)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This action cannot be undone.")
            }
        }
    }
}
