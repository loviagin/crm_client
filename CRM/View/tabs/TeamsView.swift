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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(alignment: .center) {
                    Button {
                        
                    } label: {
                        Label("New Team", systemImage: "person.3.sequence")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.9))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        
                    } label: {
                        Label("Add Employee", systemImage: "person.badge.plus")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.foreground.opacity(0.8))
                            .foregroundColor(.main)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                    
                    Menu {
                        
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 5)
                
                HStack {
                    VStack {
                        ForEach(viewModel.sections, id: \.id) { section in
                            Section {
                                VStack(spacing: 10) {
                                    ForEach(section.members) { member in
                                        EmployeeTeamMemberView(member: member, selectedMembers: $selectedMembers)
                                    }
                                }
//                                VStack(spacing: 5) {
//                                    ForEach(Array(section.members.enumerated()), id: \.1.id) { index, member in
//                                                    EmployeeTeamMemberView(member: member)
//                                                    
//                                                    if index < section.members.count - 1 {
//                                                        Divider()
//                                                            .padding(.vertical, 5)
//                                                    }
//                                                }
//                                }
                            } header: {
                                HStack {
                                    Text("\(section.group.name)")
                                        .font(.callout)
                                        .foregroundStyle(.gray)
                                    Spacer()
                                    
                                    Button {
                                        
                                    } label: {
                                        Label("Add Member", systemImage: "plus.circle")
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 10)
                                            .background(Color.blue.opacity(0.9))
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    .buttonStyle(.plain)
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
                }
            }
            .navigationTitle("Teams")
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
         position: String?
         isDirector: Bool
         joinedAt: Date?
     */
    
    var body: some View {
//        VStack {
            HStack(spacing: 10) {
                ZStack {
                    //            if let avatarURL = member.avatarURL, let url = URL(string: avatarURL) {
                    //                AsyncImage(url: url)
                    //            } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                        .blur(radius: selectedMembers.contains(member.id) ? 3 : 0)
                    //            }
                    
                    if selectedMembers.contains(member.id) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .foregroundStyle(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                    }
                }
                .onTapGesture {
                    if selectedMembers.contains(member.id) {
                        selectedMembers.removeAll { $0 == member.id }
                    } else {
                        selectedMembers.append(member.id)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(member.name)
                        .font(.title3)
                        .bold()
                    
                    if let jobTitle = member.jobTitle {
                        Text(jobTitle)
                            .font(.callout)
                    }
                }
                
                Spacer()
            }
            
//            Divider()
//        }
    }
}

#Preview {
    TeamsView()
}
