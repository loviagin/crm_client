//
//  CRMApp.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/12/25.
//

import SwiftUI

@main
struct CRMApp: App {
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewModel)
        }
    }
}
