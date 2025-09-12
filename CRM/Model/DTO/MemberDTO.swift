//
//  EmployeeListDTO.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

struct MemberDTO: Identifiable, Codable {
    let id: UUID
    let name: String
    let email: String?
    let phone: String?
    let jobTitle: String? 
    let isDirector: Bool
    let joinedAt: Date?
}
