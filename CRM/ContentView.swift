//
//  ContentView.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var isLoading = true
        
    var body: some View {
        Group {
            if isLoading { // loading state
                ProgressView()
                    .progressViewStyle(.circular)
            } else if viewModel.user == nil { // not authorized
                AuthView(isLoading: $isLoading)
            } else { // authorized
                TabsView()
            }
        }
        .task {
            let user = await viewModel.fetchUser()
            
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.user = user
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .frame(minWidth: 670, minHeight: 400)
        .environmentObject(MainViewModel.mock)
}
