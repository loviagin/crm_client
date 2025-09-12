//
//  TeamSectionDTO.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

struct TeamSectionDTO: Codable, Identifiable {
    var id: String? { group.id }
    let group: EmployeeTeam
    let members: [MemberDTO]
}
