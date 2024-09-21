//
//  SynchroSoundAccountView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI
import SwiftData

struct SynchroSoundAccountView: View {
    @EnvironmentObject var loginState: LoginState
    @StateObject var viewModel = SynchroSoundAccountViewModel()
    @Binding var showTabView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.brandDarkGray, .black]),
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [.brandBabyBlue, .brandVibrantBlue],
                                                     startPoint: .topLeading,
                                                     endPoint: .bottomTrailing))
                                .frame(width: 125, height: 125)
                            
                            Circle()
                                .fill(.brandDarkGray)
                                .frame(width: 105, height: 105)
                            
                            Image(systemName: "headphones.circle.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 90))
                        }
                        .padding(.leading, 25)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(loginState.currentUser?.name ?? "Name")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            
                            Text(loginState.currentUser?.email ?? "Email")
                                .font(.system(size: 18, weight: .light, design: .rounded))
                                .foregroundStyle(.gray)
                                .lineLimit(1)
                            
                            Spacer()
                        }
                        .padding(.leading, 15)
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .frame(height: 135)
                    .padding(.bottom, 10)
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: SynchroSoundAccountSettingsView()) {
                            AccountButton(text: "Account Settings",
                                          symbol: "gearshape.circle.fill",
                                          textColor: .black,
                                          background: .white)
                        }
                        
                            
                        
                        NavigationLink(destination: SynchroSoundLikedSongs(showTabView: $showTabView)) {
                            AccountButton(text: "Liked Songs",
                                          symbol: "heart.fill",
                                          textColor: .white,
                                          background: LinearGradient(colors: [.brandLightBlue, .brandVibrantBlue, .brandVibrantBlue],
                                                                     startPoint: .leading,
                                                                     endPoint: .trailing))
                        }
                        
                        Button {
                            loginState.isLoggedIn = false
                        } label: {
                            AccountButton(text: "Logout",
                                          symbol: "arrow.left.circle.fill",
                                          textColor: .white,
                                          background: .brandBlue)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 15)
                    
                    Divider()
                        .background(.white)
                        .frame(width: 360)
                        .padding(.vertical, 15)
                    
                    Text("Preferred Genres (\(viewModel.numSelectedGenres)/5) (Selecting May \nAffect Recommendations)")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, 10)
                    
                    SynchroSoundGenreSelection(viewModel: viewModel)
                        .padding(.bottom, 30)
                    
                    Spacer()
                }
            }
            .alert("Maximum Genre Selection Reached", isPresented: $viewModel.showingMaxSelectionAlert) {
                Button("OK") {
                    viewModel.showingMaxSelectionAlert.toggle()
                }
            } message: {
                Text("Please deselect genres before selecting more preferred genres.")
            }
        }
    }
}

#Preview {
    SynchroSoundAccountView(showTabView: .constant(true))
        .environmentObject(LoginState())
}
