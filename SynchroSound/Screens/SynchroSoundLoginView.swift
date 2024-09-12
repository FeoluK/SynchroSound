//
//  SynchroSoundLoginView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/12/24.
//

import SwiftUI
import SwiftData

struct SynchroSoundLoginView: View {
    @EnvironmentObject var loginState: LoginState
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var shouldSetLoginStatus: Bool = false 
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.brandBabyBlue, .brandVibrantBlue],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Welcome to SynchroSound!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
                VStack(spacing: 20) {
                    CustomTextField(placeholder: "Username", text: $username, iconName: "person.fill")
                    
                    CustomTextField(placeholder: "Email", text: $email, iconName: "envelope.fill", isEmail: true)
                }
                .padding(.horizontal, 40)
                
                Button(action: login) {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 280, height: 50)
                        .background(
                            LinearGradient(colors: [.brandLightBlue, .brandVibrantBlue],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .cornerRadius(12)
                        .shadow(radius: 8)
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login Status"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if shouldSetLoginStatus {
                            loginState.isLoggedIn = true
                        }
                    }
                )
            }
        }
    }
    
    private func login() {
        guard !username.isEmpty, !email.isEmpty else {
            alertMessage = "Please enter both a username and an email."
            showAlert = true
            shouldSetLoginStatus = false
            return
        }
        
        if let existingUser = users.first(where: { $0.email == email }) {
            if existingUser.name == username {
                alertMessage = "Welcome back, \(existingUser.name)!"
                loginState.currentUser = existingUser
                shouldSetLoginStatus = true
            } else {
                alertMessage = "The username you entered does not match the name saved under \(existingUser.email)."
                showAlert = true
                shouldSetLoginStatus = false
            }
        } else {
            let newUser = User(email: email, name: username)
            modelContext.insert(newUser)
            alertMessage = "Account created for \(username)."
            loginState.currentUser = newUser
            shouldSetLoginStatus = true
        }
        
        showAlert = true
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var iconName: String
    var isEmail: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.white)
                .padding(.leading, 15)
            
            TextField(placeholder, text: $text)
                .keyboardType(isEmail ? .emailAddress : .default)
                .autocapitalization(isEmail ? .none : .words)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .padding()
        }
        .background(Color.brandDarkGray.opacity(0.5))
        .cornerRadius(12)
        .shadow(radius: 8)
    }
}

#Preview {
    SynchroSoundLoginView()
}
