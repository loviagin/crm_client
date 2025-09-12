//
//  EmployeeGroup.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

struct EmployeeTeam: Identifiable, Codable {
    var id: String? = UUID().uuidString
    var name: String = ""
    var desc: String? = nil
    
    init(id: String? = nil, name: String, desc: String? = nil) {
        self.id = id
        self.name = name
        self.desc = desc
    }
    
    init() {  }
}
