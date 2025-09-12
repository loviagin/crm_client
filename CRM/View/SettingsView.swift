//
//  SettingsView.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/2/25.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {
    @AppStorage("appTheme") private var appTheme: String = "system"
    @EnvironmentObject private var viewModel: MainViewModel
    
    @State private var selectedLightImage: [PhotosPickerItem] = []
    @State private var selectedDarkImage: [PhotosPickerItem] = []
    
    @State private var loadingLightImage = false
    @State private var loadingDarkImage = false
    
    @State private var showLogoutAlert = false
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        NetworkSettingsView()
                    } label: {
                        Label("Network settings", systemImage: "network")
                    }
                }
                
                Section {
                    NavigationLink {
                        DevicesView()
                    } label: {
                        Label("Devices", systemImage: "laptopcomputer")
                    }
                }
                
                Section {
                    Text("Light logo")
                        .bold()
                        .padding(.top, 10)
                    HStack(alignment: .center, spacing: 15) {
                        PhotosPicker(selection: $selectedLightImage, maxSelectionCount: 1, matching: .images) { selectLightImageView }
                            .onChange(of: selectedLightImage) { _, newValue in
                                Task {
                                    await loadImage(newValue, type: .light)
                                }
                            }
                        
                        ImageView(imageData: $viewModel.lightLogo)
                    }
                    
                    Text("Dark logo")
                        .bold()
                        .padding(.top, 10)
                    
                    HStack(alignment: .center, spacing: 15) {
                        PhotosPicker(selection: $selectedDarkImage, maxSelectionCount: 1, matching: .images) {
                            selectDarkImageView
                        }
                        .onChange(of: selectedDarkImage) { _, newValue in
                            Task {
                                await loadImage(newValue, type: .dark)
                            }
                        }
                        
                        ImageView(imageData: $viewModel.darkLogo)
                    }
                } header: {
                    VStack(alignment: .leading) {
                        Text("Logos")
                            .font(.headline)
                            .foregroundStyle(.gray)
                        
                        Text("You can upload your company logo in dark and light modes here")
                            .font(.caption)
                    }
                }
                
                Section {
                    Picker("Choose app theme", selection: $appTheme) {
                        Text("System").tag("system")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                } header: {
                    Text("Appearance")
                        .font(.headline)
                        .foregroundStyle(.gray)
                }
                
                Section {
                    Button {
                        showLogoutAlert = true
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                            .foregroundStyle(.red)
                            .padding(5)
                    }
                    .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                        Button("Logout", role: .destructive) {
                            viewModel.logout()
                        }
                    } message: {
                        Text("You will need to enter your credentials again")
                    }
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Settings")
        }
    }
    
    var selectDarkImageView: some View {
        Group {
            if loadingDarkImage {
                ProgressView()
            } else {
                Label("Select image", systemImage: "photo")
            }
        }
        .padding(10)
    }
    
    var selectLightImageView: some View {
        Group {
            if loadingLightImage {
                ProgressView()
            } else {
                Label("Select image", systemImage: "photo")
            }
        }
        .padding(10)
    }
    
    func loadImage(_ images: [PhotosPickerItem], type: LogoType) async {
        guard let first = images.first else { return }
        
        if type == .light {
            loadingLightImage = true
        } else {
            loadingDarkImage = true
        }
        
        do {
            if let data = try await first.loadTransferable(type: Data.self) {
                if type == .light {
                    viewModel.lightLogo = data
                    loadingLightImage = false
                } else {
                    viewModel.darkLogo = data
                    loadingDarkImage = false
                }
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}

struct ImageView: View {
    @Binding var imageData: Data?
    
    var body: some View {
        if let imageData, let image = NSImage(data: imageData) {
            Image(nsImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
        }
    }
}

enum LogoType {
    case light, dark
}

#Preview {
    SettingsView()
        .frame(minWidth: 600, minHeight: 400)
        .environmentObject(MainViewModel.mock)
}
