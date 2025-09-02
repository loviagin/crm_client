//
//  EmployeeService.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

class EmployeeService {
    static let shared = EmployeeService()
    
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
}
