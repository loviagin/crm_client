//
//  User.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import Foundation

struct User: Codable {
    var id: String? = nil
    var name: String = ""
    var login: String = ""
    var email: String = ""
    var role: String = ""
    
    var createdAt: Date? = Date()
    var updatedAt: Date? = nil
    
    init(id: String? = nil, name: String, login: String, email: String, role: String, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.login = login
        self.email = email
        self.role = role
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init() {  }
    
    struct Login: Codable {
        var name: String
        var login: String
        var email: String
        var password: String
        var role: String
        
        init(name: String, login: String, email: String, password: String, role: String) {
            self.name = name
            self.login = login
            self.email = email
            self.password = password
            self.role = role
        }
    }
}
