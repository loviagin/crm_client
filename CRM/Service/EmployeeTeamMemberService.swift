//
//  EmployeeService.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

class EmployeeTeamMemberService {
    static let shared = EmployeeTeamMemberService()
    
    func getEmployeeTeamMembers(for token: String) async throws -> [EmployeeTeamMember] {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/employees/teams/members")!
        
        print("MEMBER SERVICE")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print("\(try JSONSerialization.jsonObject(with: data, options: []))")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let teamsDTOData = try decoder.decode([TeamMemberDTO].self, from: data)
        let teams = teamsDTOData.map { $0.toDomain() }
        
        print(teams)
        return teams
    }
}
