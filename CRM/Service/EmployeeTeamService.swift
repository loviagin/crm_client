//
//  EmployeeService.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

class EmployeeTeamService {
    static let shared = EmployeeTeamService()
    
    func getEmployeeTeams(for token: String) async throws -> [EmployeeTeam] {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/employees/teams")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let teamsData = try JSONDecoder().decode([EmployeeTeam].self, from: data)
        
        print(teamsData)
        return teamsData
    }
    
    func getEmployeeTeamSections(for token: String) async throws -> [TeamSectionDTO] {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/employees/teams/sections")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let teamsData = try decoder.decode([TeamSectionDTO].self, from: data)
        
        print(teamsData)
        return teamsData
    }
}
