//
//  TeamsView.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/3/25.
//

import SwiftUI

struct TeamsView: View {
    @StateObject private var viewModel = TeamsViewModel()
    
    @State private var selectedMembers: [UUID] = []
    @State private var searchText = ""
    @State private var showAllMembers = true
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView
                    .padding(.vertical, 15)
                
                HStack {
                    ScrollView {
                        ForEach(viewModel.sections, id: \.id) { section in
                            EmployeeTeamSectionView(section: section, selectedMembers: $selectedMembers, showAllMembers: $showAllMembers)
                        }
                    }
                    
                    rightView
                }
            }
            .navigationTitle("Teams")
        }
    }
    
    var headerView: some View {
        HStack(spacing: 15) {
            TextField("Search Team ...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 200)
            
            Text("\(selectedMembers.count) selected")
            
            HStack(spacing: 10) {
                Button {
                    
                } label: {
                    Label("Detach", systemImage: "personalhotspot.slash")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.main.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
                .disabled(selectedMembers.isEmpty)
                
                Button {
                    
                } label: {
                    Label("Fire", systemImage: "xmark")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.main.opacity(0.6))
                        .foregroundStyle(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
                .disabled(selectedMembers.isEmpty)
            }
            
            Spacer()
        }
    }
    
    var rightView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button {
                
            } label: {
                Label("New Team", systemImage: "person.2")
//                    .padding(10)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue.opacity(0.9))
//                    .foregroundColor(.foreground)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            
            Button {
                
            } label: {
                Label("Add Employee", systemImage: "person.badge.plus")
//                    .padding(10)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.foreground.opacity(0.8))
//                    .foregroundColor(.foreground)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            
            Button {
                
            } label: {
                Label("Attach Employee", systemImage: "person.fill.checkmark")
//                    .foregroundColor(.foreground)
            }
            .buttonStyle(.plain)
            
            Button {
//                Button("Refresh Teams") {
//                    
//                }
            } label: {
                Label("Settings", systemImage: "gearshape")
//                    .padding(10)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.gray.opacity(0.5))
//                    .foregroundColor(.foreground)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            
            Divider()
                .padding(.trailing)
            
            Button {
                withAnimation {
                    showAllMembers.toggle()
                }
            } label: {
                Label(showAllMembers ? "Hide all members" : "Show all members", systemImage: showAllMembers ? "chevron.up" : "chevron.down")
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .frame(maxWidth: 140)
//        .padding(10)
//        .overlay {
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
//        }
//        .padding(.horizontal, 1)
    }
}

struct EmployeeTeamSectionView: View {
    @State var section: TeamSectionDTO
    @Binding var selectedMembers: [UUID]
    @Binding var showAllMembers: Bool
    
    @State var showMembers = true
    @State var starred = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button {
                    withAnimation {
                        showMembers.toggle()
                    }
                } label: {
                    Image(systemName: showMembers ? "chevron.down" : "chevron.up")                .contentShape(Rectangle())

                }
                .buttonStyle(.plain)
                
                Text("\(section.group.name)")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(.gray)
                
                Button {
                    withAnimation {
                        starred.toggle()
                    }
                } label: {
                    Image(systemName: starred ? "star.fill" : "star")                .contentShape(Rectangle())
                        .foregroundStyle(starred ? .orange : .gray)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(.plain)
                
                Button {
                    
                } label: {
                    Label("Add Member", systemImage: "plus.circle")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.foreground.opacity(0.8))
                        .foregroundColor(.main)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
            }
            
            if showMembers {
                ForEach(section.members) { member in
                    EmployeeTeamMemberView(member: member, selectedMembers: $selectedMembers)
                    
                    if section.members.last != member {
                        Divider()
                    }
                }
            }
        }
        .padding(15)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
        }
        .padding(.horizontal, 1)
        .padding(.vertical, 1)
        .onChange(of: showAllMembers) { _, newValue in
            withAnimation {
                showMembers = newValue
            }
        }
    }
}

struct EmployeeTeamMemberView: View {
    @State var member: MemberDTO
    @Binding var selectedMembers: [UUID]
    
    /*
     yes name: String
         email: String?
         phone: String?
         jobTitle: String?
         isDirector: Bool
         joinedAt: Date?
     yes role: String?
     */
    
    var body: some View {
//        VStack {
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.secondary)
                    .blur(radius: selectedMembers.contains(member.id) ? 3 : 0)
                    .overlay(alignment: .center) {
                        if selectedMembers.contains(member.id) {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.white.opacity(0.95))
                                .shadow(radius: 1)
                                .opacity(0.7)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if let i = selectedMembers.firstIndex(of: member.id) {
                            selectedMembers.remove(at: i)
                        } else {
                            selectedMembers.append(member.id)
                        }
                    }
                
                VStack(alignment: .leading) {
                    Text(member.name)
//                        .font(.title3)
                        .bold()
                    
                    if let role = member.role {
                        Text(role)
                            .font(.callout)
                    }
                }
                
                Spacer()
            }
            
//        }
    }
}

#Preview {
    TeamsView()
}
