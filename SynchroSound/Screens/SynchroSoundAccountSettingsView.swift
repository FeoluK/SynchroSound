//
//  SynchroSoundAccountSettingsView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/13/24.
//

import SwiftUI
import SwiftData

struct SynchroSoundAccountSettingsView: View {
    @State private var nameText = ""
    @State private var emailText = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @EnvironmentObject var loginState: LoginState
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
                           startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Account Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                
                TextField("Name", text: $nameText)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .foregroundStyle(.black)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 1))
                
                TextField("Email", text: $emailText)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .foregroundStyle(.black)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 1))
                
                Spacer()
                
                Button {
                    saveChanges()
                } label: {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
       
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                
            }
            .padding()
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK") {
                showingAlert = false
            }
        }
        .onAppear {
            nameText = loginState.currentUser?.name ?? "Error Occured"
            emailText = loginState.currentUser?.email ?? "Error Ocurred"
        }

    }
    
    private func saveChanges() {
        guard let user = loginState.currentUser else {
            alertMessage = "Error: Could not find user!"
            showingAlert = true
            return
        }
        
        guard emailText.isValidEmail else {
            alertMessage = "Invalid Email!"
            showingAlert = true
            return
        }
        
        guard !nameText.isEmpty else {
            alertMessage = "Please enter a username"
            showingAlert = true
            return
        }
        
        
        if users.contains(where: { $0.email == emailText && $0.id != user.id }) {
            alertMessage = "Email is already in use by another account!"
            showingAlert = true
            return
        }
        
        do {
            user.name = nameText
            user.email = emailText
            try modelContext.save()
            showingAlert = true
            alertMessage = "Succesfully saved changes!"
            return
            
        } catch {
            alertMessage = "Failed to save user data: \(error)"
            showingAlert = true
        }
    }

}

#Preview {
    SynchroSoundAccountSettingsView()
        .environmentObject(LoginState())
}
