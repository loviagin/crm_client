//
//  TeamsViewModel.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

class TeamsViewModel: ObservableObject {
    @Published var teams: [EmployeeTeam] = []
    @Published var members: [EmployeeTeamMember] = []
    @Published var sections: [TeamSectionDTO] = []
    
    init() {
        Task { @MainActor in
//            self.teams = await fetchTeams()
//            self.members = await fetchTeamsMembers()
            self.sections = await fetchSections()
        }
    }
    
    func fetchSections() async -> [TeamSectionDTO] {
        guard let token = KeychainHelper.shared.readString(account: "authToken") else {
            print("no token")
            return []
        }
        
        do {
            return try await EmployeeTeamService.shared.getEmployeeTeamSections(for: token)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchTeams() async -> [EmployeeTeam] {
        guard let token = KeychainHelper.shared.readString(account: "authToken") else {
            print("no token")
            return []
        }
        
        do {
            return try await EmployeeTeamService.shared.getEmployeeTeams(for: token)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetchTeamsMembers() async -> [EmployeeTeamMember] {
        guard let token = KeychainHelper.shared.readString(account: "authToken") else {
            print("no token")
            return []
        }
        
        do {
            return try await EmployeeTeamMemberService.shared.getEmployeeTeamMembers(for: token)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
