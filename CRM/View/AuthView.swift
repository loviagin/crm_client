//
//  AuthView.swift
//  CRM
//
//  Created by Ilia Loviagin on 8/23/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @Binding var isLoading: Bool

    @State private var isRegistration = false
    
    @FocusState private var focuseField: FocuseField?
    @State private var name = ""
    @State private var email = ""
    @State private var login = ""
    @State private var password = ""
    @State private var role: Role = .admin
    
    @State private var showError = false
    @State private var errorMessage = ""
    
    var maxWidth: CGFloat = 350
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LogoView()
                        .padding(.bottom)

                    if isRegistration {
                        registrationView
                    } else {
                        loginView
                        loginButtonsView
                    }
                }
                .padding(30)
            }
            .scrollIndicators(.never)
            .navigationTitle("Login")
            .onAppear {
                withAnimation {
                    focuseField = .login
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16)
    //                    Text("Settings")
                    }
                    .buttonStyle(.plain)
                }
            })
            .alert("CRM", isPresented: $showError) {
                Button("OK", role: .destructive) {
                    setError()
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
//    var logoView: some View {
//        Group {
//            if let data = colorScheme == .light ?
//                viewModel.darkLogo : viewModel.lightLogo,
//                let image = NSImage(data: data) {
//                Image(nsImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 200)
//            } else {
//                Text("CRM")
//                    .font(.largeTitle)
//                    .bold()
//            }
//        }
//        .padding(.bottom)
//    }
    
    var loginButtonsView: some View {
        VStack {
            AppButton(text: isRegistration ? "Sign up" : "Login", maxWidth: maxWidth, disable: $isLoading) {
                loginAction()
            }
            .padding(.top, 5)
            
            Divider()
                .frame(maxWidth: maxWidth)
                .padding(8)
            
            HStack {
                AppButton(text: isRegistration ? "Login" : "Sign up", maxWidth: maxWidth, backgroundColor: Color.blue.opacity(0.8), disable: $isLoading) {
                    withAnimation {
                        isRegistration.toggle()
                        focuseField = isRegistration ? .name : .login
                    }
                }
                
                AppButton(text: "Login by Invite Code", maxWidth: maxWidth, backgroundColor: Color.gray, disable: $isLoading) {
                    
                }
            }
            .frame(maxWidth: maxWidth)
        }
    }
    
    var registrationView: some View {
        VStack(spacing: 10) {
            TextField("Your name", text: $name)
                .textFieldStyle(.roundedBorder)
                .focused($focuseField, equals: .name)
                .textContentType(.name)
                .frame(maxWidth: maxWidth)
                .submitLabel(.next)
                .onSubmit {
                    focuseField = .email
                }
            
            TextField("Your email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textContentType(.emailAddress)
                .focused($focuseField, equals: .email)
                .frame(maxWidth: maxWidth)
                .submitLabel(.next)
                .onSubmit {
                    focuseField = .login
                }
            
            loginView
            
            Picker("Choose your role", selection: $role) {
                ForEach(Role.allCases, id:\.self) { r in
                    Button(r.rawValue) {
                        self.role = r
                    }
                    .tag(r)
                }
            }
            .focused($focuseField, equals: .role)
            .frame(maxWidth: maxWidth)
            .disabled(true)
            
            loginButtonsView
        }
    }
    
    var loginView: some View {
        VStack(spacing: 10) {
            TextField("Login", text: $login)
                .textFieldStyle(.roundedBorder)
                .textContentType(.username)
                .autocorrectionDisabled()
                .focused($focuseField, equals: .login)
                .frame(maxWidth: maxWidth)
                .submitLabel(.next)
                .onSubmit {
                    focuseField = .password
                }
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .textContentType(.password)
                .focused($focuseField, equals: .password)
                .frame(maxWidth: maxWidth)
                .submitLabel(.go)
                .onSubmit {
                    focuseField = nil
                    loginAction()
                }
        }
    }
    
    func registerAction() {
        guard !name.isEmpty else {
            setError("Name field is required")
            return
        }
        
        guard !email.isEmpty else {
            setError("Email field is required")
            return
        }
        
        withAnimation {
            isLoading = true
        }
        
        Task {
            if let user = await viewModel.register(name: name, email: email, login: login, password: password, role: role) {
                DispatchQueue.main.async {
                    viewModel.user = user
                }
            } else {
                setError("Invalid login or password")
            }
            
            withAnimation {
                isLoading = false
            }
        }
    }
    
    func loginAction() {
        guard !login.isEmpty else {
            setError("Login field is required")
            return
        }
        
        guard !password.isEmpty && password.count >= 8 else {
            setError("Password field must to be at least 8 characters")
            return
        }
        
        if isRegistration {
            registerAction()
            return
        }
        
        withAnimation {
            isLoading = true
        }
        
        Task {
            if let user = await viewModel.login(login: login, password: password) {
                DispatchQueue.main.async {
                    viewModel.user = user
                }
            } else {
                setError("Invalid login or password")
            }
            
            withAnimation {
                isLoading = false
            }
        }
    }
    
    func setError(_ message: String? = nil) {
        if let message {
            errorMessage = NSLocalizedString(message, comment: "Auth View")
            showError = true
        } else {
            errorMessage = ""
            showError = false
        }
    }
    
    enum FocuseField {
        case login, password, name, email, role
    }
}


struct LogoView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var viewModel: MainViewModel

    @State var imageWidth: CGFloat = 200
    @State var imageHeight: CGFloat = 50
    
    var body: some View {
        VStack {
            if let data = colorScheme == .light ?
                viewModel.darkLogo : viewModel.lightLogo,
                let image = NSImage(data: data) {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: imageHeight)
            } else {
                Text("CRM")
                    .font(.largeTitle)
                    .bold()
            }
        }
    }
}
