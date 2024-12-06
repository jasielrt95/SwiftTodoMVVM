//
//  TaskRowView.swift
//  SwiftToDo
//
//  Created by Jasiel Rivera Trinidad on 12/5/24.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .imageScale(.large)
                    .accessibilityLabel(task.isCompleted ? "Completed" : "Not completed")
                    .accessibilityHint("Tap to toggle completion status")
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)
            
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.vertical, 8)
    }
}
