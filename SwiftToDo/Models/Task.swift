//
//  Task.swift
//  SwiftToDo
//
//  Created by Jasiel Rivera Trinidad on 12/5/24.
//

import Foundation


struct Task: Identifiable, Codable {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = Date()
    }
    
}
