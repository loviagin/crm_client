//
//  EmployeesViewModel.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/13/25.
//

import Foundation

class EmployeesViewModel: ObservableObject {
//    @Published var teams: [EmployeeTeam] = []
    @Published var employees: [Employee] = []
    
    init() {
        Task { @MainActor in
//            self.teams = await fetchTeams()
            self.employees = await fetchTeamsEmployees()
        }
    }
    
//    func fetchTeams() async -> [EmployeeTeam] {
//        guard let token = KeychainHelper.shared.readString(account: "authToken") else {
//            print("no token")
//            return []
//        }
//        
//        do {
//            return try await EmployeeTeamService.shared.getEmployeeTeams(for: token)
//        } catch {
//            print(error.localizedDescription)
//            return []
//        }
//    }
    
    func fetchTeamsEmployees() async -> [Employee] {
        guard let token = KeychainHelper.shared.readString(account: "authToken") else {
            print("no token")
            return []
        }
        
        do {
            return try await EmployeeService.shared.getEmployees(for: token)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
