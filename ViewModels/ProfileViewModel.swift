//
//  ProfileViewModel.swift
//  SwiftToDo
//
//  Created by Jasiel Rivera Trinidad on 12/5/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var name: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @Published var email: String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
    
    func saveProfile() {
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(email, forKey: "userEmail")
    }
}
