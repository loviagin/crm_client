//
//  TabsView.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import SwiftUI

struct TabsView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
//    #if DEBUG
//    @State private var showSidebar = false
//    #else
    @State private var showSidebar = true
//    #endif
    
    var body: some View {
        HStack {
            sidebarView
            
            switch viewModel.selectedTab {
            case .home:
                DashboardView()
            case .finance:
                FinanceView()
            case .settings:
                SettingsView()
            case .teams:
                TeamsView()
            case .employees:
                EmployeesView()
            case .another:
                DevelopingView()
            }
            
            Spacer()
        }
    }
    
    var sidebarView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    logoSidebarView
                    
                    dividerSidebarView
                    
                    // MARK: - MENU ITEMS
                    VStack(alignment: .leading, spacing: 0) {
                        SidebarButtonView(showSidebar: $showSidebar, icon: "house", text: "Dashboard", tab: .home, number: "1")
                        .padding(.bottom, 5)
                        
                        SidebarButtonView(showSidebar: $showSidebar, icon: "dollarsign.circle", text: "Finance", tab: .finance, number: "2")
                        SidebarMenuButtonView(showSidebar: $showSidebar, icon: "person.2.circle", text: "Team", currentTab: .teams, tabs: [.teams, .employees], number: "3")
                        if viewModel.selectedTab == .teams || viewModel.selectedTab == .employees {
                            SidebarButtonSubView(showSidebar: $showSidebar, icon: "person.3", text: "Teams", tab: .teams)
                            SidebarButtonSubView(showSidebar: $showSidebar, icon: "person.2", text: "Employees", tab: .employees)
                        }
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
                LogoView(imageWidth: 110, imageHeight: 25)
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

struct SidebarMenuButtonView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    @Binding var showSidebar: Bool
    @State var icon: String
    @State var text: String
    @State var currentTab: AppTab
    @State var tabs: [AppTab]
    @State var number: KeyEquivalent
    
    var body: some View {
        Button {
            withAnimation {
                viewModel.selectedTab = currentTab
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
                if tabs.contains(viewModel.selectedTab) {
                    RoundedRectangle(cornerRadius: 0).fill(Color.foreground.opacity(0.1))
                }
            }
        }
        .buttonStyle(.plain)
        .keyboardShortcut(number, modifiers: .command)
    }
}

struct SidebarButtonSubView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    @Binding var showSidebar: Bool
    @State var icon: String
    @State var text: String
    @State var tab: AppTab
    
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
            .padding(.leading, 25)
            .padding(.trailing, 15)
            .frame(maxWidth: showSidebar ? 150 : 55, alignment: .leading)
            .contentShape(Rectangle())
            .overlay {
                if viewModel.selectedTab == tab {
                    RoundedRectangle(cornerRadius: 0).fill(Color.foreground.opacity(0.2))
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TabsView()
        .frame(minWidth: 700, minHeight: 400)
        .environmentObject(MainViewModel.mock)
}
