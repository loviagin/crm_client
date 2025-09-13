//
//  TeamsViewModel.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import Foundation

class TeamsViewModel: ObservableObject {
    @Published var sections: [TeamSectionDTO] = []
    
    init() {
        Task { @MainActor in
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
}
