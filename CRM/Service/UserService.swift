//
//  UserService.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import Foundation

class UserService {
    static let shared = UserService()
    
    func checkToken() -> String? { // true if we already have token (user is authenticated)
        return KeychainHelper.shared.readString(account: "authToken")
    }
    
    func registerUser(_ user: User.Login) async throws -> String? {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/users")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(user)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            let dataString = String(data: data, encoding:
                    .utf8) ?? "Data not readable as string"
            print("Error: \(httpResponse.statusCode) \(dataString)")
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return json?["value"] as? String
    }
    
    func loadUser(_ token: String) async throws -> User? {
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/users/me")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            let dataString = String(data: data, encoding:
                    .utf8) ?? "Data not readable as string"
            print("Error: \(httpResponse.statusCode) \(dataString)")
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let json = try decoder.decode(User.self, from: data)
        return json
    }
    
    func login(login: String, password: String) async throws -> String? { // return token string
        let url = URL(string: NetworkEnum.baseUrl.rawValue + "/users/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "login": login,
            "password": password
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            let dataString = String(data: data, encoding: .utf8) ?? "No data"
            print("Error: \(httpResponse.statusCode) \(dataString)")
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        return json?["value"] as? String
    }
}
