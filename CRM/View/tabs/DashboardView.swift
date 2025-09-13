//
//  MainView.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @StateObject private var dViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(alignment: .center) {
                    Text(Date().formatted(
                        .dateTime
                            .weekday(.abbreviated)
                            .month(.abbreviated)
                            .day()
                    ))
                    .font(.title3)
                    .padding(.top, 5)
                    
                    Spacer()
                    
                    //MARK: - AI integration
                    //TODO: - search/type field
                }
                .frame(height: 45)
                
                HStack(alignment: .top) {
                    //MARK: - Statistics
                    VStack {
                        VStack(alignment: .center, spacing: 6) {
                            Text("\(dViewModel.employeesCount)")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .monospacedDigit()
                            Text("Employees")
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)
                                .tracking(0.8)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.foreground.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        //                    VStack(alignment: .center, spacing: 6) {
                        //                        Text("\(dViewModel.employeesCount)")
                        //                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        //                            .monospacedDigit()
                        //                        Text("Employees")
                        //                            .font(.footnote.weight(.semibold))
                        //                            .foregroundStyle(.secondary)
                        //                            .textCase(.uppercase)
                        //                            .tracking(0.8)
                        //                    }
                        //                    .padding(10)
                        //                    .frame(maxWidth: .infinity)
                        //                    .background(Color.foreground.opacity(0.1))
                        //                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    VStack {
                        VStack(alignment: .center, spacing: 6) {
                            Text("\(dViewModel.teamsCount)")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .monospacedDigit()
                            Text("Teams")
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)
                                .tracking(0.8)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.foreground.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        //                    VStack(alignment: .center, spacing: 6) {
                        //                        Text("\(dViewModel.employeesCount)")
                        //                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        //                            .monospacedDigit()
                        //                        Text("Employees")
                        //                            .font(.footnote.weight(.semibold))
                        //                            .foregroundStyle(.secondary)
                        //                            .textCase(.uppercase)
                        //                            .tracking(0.8)
                        //                    }
                        //                    .padding(10)
                        //                    .background(Color.foreground.opacity(0.1))
                        //                    .clipShape(RoundedRectangle(cornerRadius: 12))
                        //                    
                        //                    VStack(alignment: .center, spacing: 6) {
                        //                        Text("\(dViewModel.employeesCount)")
                        //                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        //                            .monospacedDigit()
                        //                        Text("Employees")
                        //                            .font(.footnote.weight(.semibold))
                        //                            .foregroundStyle(.secondary)
                        //                            .textCase(.uppercase)
                        //                            .tracking(0.8)
                        //                    }
                        //                    .padding(10)
                        //                    .frame(maxWidth: .infinity)
                        //                    .background(Color.foreground.opacity(0.1))
                        //                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    }.frame(maxWidth: .infinity)
                    
                    //MARK: - Profile
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .padding(10)
                        
                        Text("\(viewModel.user?.name ?? "")")
                            .bold()
                        
                        Text("\(viewModel.user?.role ?? "")")
                            .font(.subheadline)
                            .padding(.bottom, 5)
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                Text("My Profile")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(5)
                            .background(Color.blue.opacity(0.9))
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "square.and.pencil.circle.fill")
                                Text("Edit details")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(5)
                            .background(Color.foreground.opacity(0.4))
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(MainViewModel.mock)
}
