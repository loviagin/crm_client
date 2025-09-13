//
//  DashboardViewModel.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var employeesCount: Int = 0
    @Published var teamsCount: Int = 0
    
    init() {
        Task { @MainActor in
            self.employeesCount = await  self.getEmployeesCount()
            self.teamsCount = await  self.getTeamsCount()
        }
    }
    
    func getTeamsCount() async -> Int {
        guard let token = KeychainHelper.shared.readString(account: "authToken") else {
            print("No token")
            return 0
        }
        
        do {
            return try await EmployeeService.shared.getTeamsCount(for: token) ?? 0
        } catch {
            print(error)
            return 0
        }
    }
    
    func getEmployeesCount() async -> Int {
        guard let token = KeychainHelper.shared.readString(account: "authToken") else {
            print("No token")
            return 0
        }
        
        do {
            return try await EmployeeService.shared.getEmployeeCount(for: token) ?? 0
        } catch {
            print(error)
            return 0
        }
    }
}
