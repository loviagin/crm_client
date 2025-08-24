//
//  UserDTO.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/24/25.
//

import Foundation

struct UserDTO: Codable {
    var id: String? = nil
    var name: String? = nil
    var login: String? = nil
    var email: String? = nil
    var role: String? = nil
    
    var createdAt: Date? = nil
    var updatedAt: Date? = nil
    
    init(id: String? = nil, name: String? = nil, login: String? = nil, email: String? = nil, role: String? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.login = login
        self.email = email
        self.role = role
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init() {  }
}
