//
//  SynchroSoundAccountView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/3/24.
//

import SwiftUI

import SwiftUI
import SwiftData

struct SynchroSoundAccountView: View {
    @EnvironmentObject var loginState: LoginState
    @StateObject var viewModel = SynchroSoundAccountViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.brandDarkGray
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
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(loginState.currentUser?.name ?? "Name")
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            
                            Text(loginState.currentUser?.email ?? "email")
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .tint(.white)
                                .lineLimit(1)

                        }
                        .padding(.trailing, 22)
                    }
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 15) {
                        Button {
                            
                        } label: {
                            AccountButton(text: "Account Settings",
                                          symbol: "gearshape.circle.fill",
                                          textColor: .black,
                                          background: .white)
                        }
                        
                        NavigationLink(destination: SynchroSoundLikedSongs(email: loginState.currentUser?.name ?? "Name",
                                                                           name: loginState.currentUser?.email ?? "Email")) {
                            AccountButton(text: "Liked Songs",
                                          symbol: "heart.fill",
                                          textColor: .white,
                                          background: LinearGradient(colors: [.brandLightBlue, .brandVibrantBlue, .brandVibrantBlue],
                                                                     startPoint: .leading,
                                                                     endPoint: .trailing))
                        }
                        
                        NavigationLink(destination: SynchroSongFavoriteMoods()) {
                            AccountButton(text: "Saved Moods",
                                          symbol: "bookmark.fill",
                                          textColor: .white,
                                          background: .brandCyan)
                        }
                        
                        Button{
                            loginState.isLoggedIn = false
                        } label: {
                            AccountButton(text: "Logout",
                                          symbol: "arrow.left.circle.fill",
                                          textColor: .white,
                                          background: .brandBlue )
                        }
                    }
                    
                    Divider()
                        .background(.white)
                        .frame(width: 360)
                        .padding(.top, 10)
                    
                    Text("Preferred Genres (\(viewModel.numSelectedGenres)/5)")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, 10)
                    
                    SynchroSoundGenreSelection(viewModel: viewModel)
                        .padding(.bottom, 15)
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


struct SynchroSongFavoriteMoods: View {
    var body: some View {
        Text("Saved Moods")
            .navigationTitle("Saved Moods")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SynchroSoundAccountView()
        .environmentObject(LoginState())
}
