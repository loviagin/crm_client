//
//  CRMApp.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/12/25.
//

import SwiftUI

@main
struct CRMApp: App {
    @AppStorage("appTheme") private var appTheme: String = "system"
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(colorScheme)
                .frame(minWidth: 800, minHeight: 500)
                .environmentObject(mainViewModel)
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch appTheme {
        case "light": return .light
        case "dark": return .dark
        default: return nil // системная
        }
    }
}
