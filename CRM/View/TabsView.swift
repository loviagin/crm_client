//
//  TabsView.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import SwiftUI

struct TabsView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    @State private var showSidebar = true
    
    var body: some View {
        NavigationStack {
            HStack {
                sidebarView
                
                switch viewModel.selectedTab {
                case .home:
                    DashboardView()
                case .finance:
                    FinanceView()
                case .settings:
                    SettingsView()
                case .another:
                    DevelopingView()
                }
                
                Spacer()
            }
        }
    }
    
    var sidebarView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    logoSidebarView
                    
                    dividerSidebarView
                    
                    //MARK: - MENU ITEMS
                    VStack(alignment: .leading, spacing: 0) {
                        SidebarButtonView(showSidebar: $showSidebar, icon: "house", text: "Dashboard", tab: .home, number: "1")
                        .padding(.bottom, 5)
                        
                        SidebarButtonView(showSidebar: $showSidebar, icon: "dollarsign.circle", text: "Finance", tab: .finance, number: "2")
                        SidebarButtonView(showSidebar: $showSidebar, icon: "person.2.circle", text: "Teams", tab: .another, number: "3")
                    }
                }
                .padding(.top)
            }
            
            Spacer()
            
            SidebarButtonView(showSidebar: $showSidebar, icon: "gearshape", text: "Settings", tab: .settings, number: "0")
                .padding(.bottom, 5)
            
            dividerSidebarView
            
            Button {
                withAnimation(.spring) {
                    showSidebar.toggle()
                }
            } label: {
                Image(systemName: showSidebar ? "chevron.backward" : "chevron.forward")
                    .padding()
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .keyboardShortcut(.rightArrow, modifiers: [.command])
        }
        .background(Color.main)
    }
    
    var logoSidebarView: some View {
        Group {
            if showSidebar {
                LogoView(imageWidth: 100, imageHeight: 25)
            } else {
                Text("C")
                    .font(.largeTitle)
                    .bold()
            }
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
    
    var dividerSidebarView: some View {
        Divider()
            .frame(maxWidth: showSidebar ? 130 : 55)
    }
}

struct SidebarButtonView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    @Binding var showSidebar: Bool
    @State var icon: String
    @State var text: String
    @State var tab: AppTab
    @State var number: KeyEquivalent
    
    var body: some View {
        Button {
            withAnimation {
                viewModel.selectedTab = tab
            }
        } label: {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 17)
                
                if showSidebar {
                    Text(text)
                }
            }
            .padding(.vertical, 7)
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .frame(maxWidth: showSidebar ? 150 : 55, alignment: .leading)
            .contentShape(Rectangle())
            .overlay {
                if viewModel.selectedTab == tab {
                    RoundedRectangle(cornerRadius: 0).fill(Color.foreground.opacity(0.1))
                }
            }
        }
        .buttonStyle(.plain)
        .keyboardShortcut(number, modifiers: .command)
    }
}

#Preview {
    TabsView()
        .frame(minWidth: 600, minHeight: 400)
        .environmentObject(MainViewModel.mock)
}
