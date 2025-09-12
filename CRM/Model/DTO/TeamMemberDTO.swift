//
//  GroupMemberDTO.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

struct TeamMemberDTO: Codable {
    let id: UUID
    let role: String?
    let joinedAt: Date?
    let group: IdRef
    let employee: IdRef
    
    func toDomain() -> EmployeeTeamMember {
        EmployeeTeamMember(
            id: id.uuidString,
            employeeId: employee.id.uuidString,
            groupId: group.id.uuidString,
            role: role,
            joinedAt: joinedAt
        )
    }
}
