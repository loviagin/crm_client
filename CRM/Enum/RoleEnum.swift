//
//  RoleEnum.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/24/25.
//

import Foundation

enum Role: String, Codable, CaseIterable {
    case admin = "admin"
    case finance = "finance"
    case hr = "hr"
    case manager = "manager"
    case readOnly = "read_only"
}
