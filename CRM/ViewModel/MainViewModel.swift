//
//  MainViewModel.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var selectedTab: AppTab = .home
    @Published var user: User? = nil
    
    @Published var lightLogo: Data? {
        didSet {
            UserDefaults.standard.set(lightLogo, forKey: "logo_light")
        }
    }
    @Published var darkLogo: Data? {
        didSet {
            UserDefaults.standard.set(darkLogo, forKey: "logo_dark")
        }
    }
    
    init() {
        (lightLogo, darkLogo) = getLogos()
    }
    
    func fetchUser() async -> User? {
        if let token = UserService.shared.checkToken() {
            do {
                print("here")
                return try await UserService.shared.loadUser(token)
            } catch {
                print(error)
                return nil
            }
        }
        
        return nil
    }
    
    func register(name: String, email: String, login: String, password: String, role: Role) async -> User? {
        let user = User.Login(name: name, login: login, email: email, password: password, role: role.rawValue)
        do {
            if let token = try await UserService.shared.registerUser(user) {
                KeychainHelper.shared.save(token, account: "authToken")
                return await fetchUser()
            } else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func login(login: String, password: String) async -> User? {
        do {
            print("no token")
            if let token = try await UserService.shared.login(login: login, password: password) {
                print("token: \(token)")
                KeychainHelper.shared.save(token, account: "authToken")
                return try await UserService.shared.loadUser(token)
            } else { return nil }
        } catch {
            print(error)
            return nil
        }
    }
    
    func getLogos() -> (Data?, Data?) {
        return (UserDefaults.standard.data(forKey: "logo_light"), UserDefaults.standard.data(forKey: "logo_dark"))
    }
 
    func logout() {
        DispatchQueue.main.async {
            self.user = nil
            KeychainHelper.shared.delete(account: "authToken")
        }
    }
}

enum AppTab {
    case home, finance, settings, teams, another
}

extension MainViewModel {
    static var mock: MainViewModel {
        let viewModel = MainViewModel()
        viewModel.selectedTab = .teams
        viewModel.user = User(name: "Ilia", login: "ilia", email: "ilia@lovigin.com", role: "admin")
        return viewModel
    }
}
