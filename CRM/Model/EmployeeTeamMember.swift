//
//  EmployeeTeamMember.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

struct EmployeeTeamMember: Identifiable, Codable {
    var id: String         = UUID().uuidString
    var employeeId: String = ""
    var groupId: String    = ""
    var role: String?      = nil  // "owner" | "admin" | "member"
    var joinedAt: Date?    = nil
}
