//
//  EmployeeService.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

class EmployeeService {
    static let shared = EmployeeService()
    
    func getEmployees(for token: String) async throws -> [Employee] {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/employees")!
        
        print("EMPLOYEE SERVICE")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print("\(try JSONSerialization.jsonObject(with: data, options: []))")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let employees = try decoder.decode([Employee].self, from: data)
        
        print(employees)
        return employees
    }
    
    func getEmployeeCount(for token: String) async throws -> Int? {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/employees/count")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (response, _) = try await URLSession.shared.data(for: request)
        let dataInt = try JSONDecoder().decode(Int.self, from: response)
        
        print(dataInt)
        return dataInt
    }
    
    func getTeamsCount(for token: String) async throws -> Int? {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/employees/teams/count")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (response, _) = try await URLSession.shared.data(for: request)
        let dataInt = try JSONDecoder().decode(Int.self, from: response)
        
        print(dataInt)
        return dataInt
    }
}
