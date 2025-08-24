//
//  TabsView.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import SwiftUI

struct TabsView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            MainView()
                .tabItem {
                    Label("Main", systemImage: "house")
                }
                .tag(AppTab.home)
            
            Spacer()
            
            MainView()
                .tabItem {
                    Label("Not main", systemImage: "house")
                }
                .tag(AppTab.home)
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    TabsView()
        .environmentObject(MainViewModel.mock)
}
