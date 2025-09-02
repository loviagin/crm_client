//
//  MainView.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        ScrollView {
            Button("Logout") {
                viewModel.logout()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(MainViewModel.mock)
}
