//
//  EmployeesView.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/13/25.
//

import SwiftUI

struct EmployeesView: View {
    @StateObject private var viewModel = EmployeesViewModel()
    
    @State private var selectedEmployees: [UUID] = []
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView
                    .padding(.vertical, 15)
                
                HStack {
                    ScrollView {
                        ForEach(viewModel.employees, id: \.id) { employee in
                            EmployeeTeamView(employee: employee, selectedEmployees: $selectedEmployees)
                        }
                    }
                    
                    rightView
                }
            }
            .navigationTitle("Employees")
        }
    }
    
    var headerView: some View {
        HStack(spacing: 15) {
            TextField("Search Employee ...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 200)
            
            Text("\(selectedEmployees.count) selected")
            
            HStack(spacing: 10) {
                Button {
                    
                } label: {
                    Label("Pay Salary", systemImage: "creditcard.circle")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.main.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
                .disabled(selectedEmployees.isEmpty)
                
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
                .disabled(selectedEmployees.isEmpty)
            }
            
            Spacer()
        }
    }
    
    var rightView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button {
                
            } label: {
                Label("New Employee", systemImage: "person")
            }
            .buttonStyle(.plain)
            
            //            Button {
            //
            //            } label: {
            //                Label("Add Employee", systemImage: "person.badge.plus")
            //            }
            //            .buttonStyle(.plain)
            
            Button {
                
            } label: {
                Label("Attach Employee", systemImage: "person.fill.checkmark")
            }
            .buttonStyle(.plain)
            
            Button {
                
            } label: {
                Label("Settings", systemImage: "gearshape")
            }
            .buttonStyle(.plain)
            
            Divider()
                .padding(.trailing)
            
            Spacer()
        }
        .frame(maxWidth: 140)
    }
}

//struct EmployeeTeamSectionView: View {
//    @State var section: TeamSectionDTO
//    @Binding var selectedMembers: [UUID]
//    @Binding var showAllMembers: Bool
//
//    @State var showMembers = true
//    @State var starred = false
//
//    var body: some View {
//        VStack(spacing: 10) {
//            HStack {
//                Button {
//                    withAnimation {
//                        showMembers.toggle()
//                    }
//                } label: {
//                    Image(systemName: showMembers ? "chevron.down" : "chevron.up")                .contentShape(Rectangle())
//
//                }
//                .buttonStyle(.plain)
//
//                Text("\(section.group.name)")
//                    .font(.callout)
//                    .bold()
//                    .foregroundStyle(.gray)
//
//                Button {
//                    withAnimation {
//                        starred.toggle()
//                    }
//                } label: {
//                    Image(systemName: starred ? "star.fill" : "star")                .contentShape(Rectangle())
//                        .foregroundStyle(starred ? .orange : .gray)
//                }
//                .buttonStyle(.plain)
//
//                Spacer()
//
//                Button {
//
//                } label: {
//                    Image(systemName: "magnifyingglass")
//                }
//                .buttonStyle(.plain)
//
//                Button {
//
//                } label: {
//                    Label("Add Member", systemImage: "plus.circle")
//                        .padding(.vertical, 5)
//                        .padding(.horizontal, 10)
//                        .background(Color.foreground.opacity(0.8))
//                        .foregroundColor(.main)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
//                .buttonStyle(.plain)
//            }
//
//            if showMembers {
//                ForEach(section.members) { member in
//                    EmployeeTeamMemberView(member: member, selectedMembers: $selectedMembers)
//
//                    if section.members.last != member {
//                        Divider()
//                    }
//                }
//            }
//        }
//        .padding(15)
//        .overlay {
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
//        }
//        .padding(.horizontal, 1)
//        .padding(.vertical, 1)
//        .onChange(of: showAllMembers) { _, newValue in
//            withAnimation {
//                showMembers = newValue
//            }
//        }
//    }
//}

struct EmployeeTeamView: View {
    @State var employee: Employee
    @Binding var selectedEmployees: [UUID]
    
    /*
     yes name: String
     email: String?
     phone: String?
     yes jobTitle: String?
     isDirector: Bool
     joinedAt: Date?
     role: String?
     */
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(.secondary)
                .blur(radius: selectedEmployees.contains(employee.id) ? 3 : 0)
                .overlay(alignment: .center) {
                    if selectedEmployees.contains(employee.id) {
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
                    if let i = selectedEmployees.firstIndex(of: employee.id) {
                        selectedEmployees.remove(at: i)
                    } else {
                        selectedEmployees.append(employee.id)
                    }
                }
            
            VStack(alignment: .leading) {
                Text(employee.name)
                    .bold()
                
                Text(employee.jobTitle)
                    .font(.callout)
            }
            
            Spacer()
        }
    }
}

#Preview {
    EmployeesView()
}
