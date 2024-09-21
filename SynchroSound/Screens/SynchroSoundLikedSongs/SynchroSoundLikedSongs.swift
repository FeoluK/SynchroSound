//
//  SynchroSoundLikedSongs.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/10/24.
//
import SwiftUI
import SwiftData

struct SynchroSoundLikedSongs: View {
    
    @EnvironmentObject var loginState: LoginState
    @StateObject var viewModel = SynchroSoundLikedSongsViewModel()
    @Query var users: [User]
    @Binding var showTabView: Bool
    
    var user: User? {
        users.first { $0.email == loginState.currentUser?.email }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
                           startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            if let user = user, !user.favoriteSongs.isEmpty {
                SynchroSoundLikedSongsContent(viewModel: viewModel)
                
                if viewModel.showingDetailView {
                    SynchroSoundLikedSongsDetailView(track: viewModel.selectedTrack ??
                                                     MockSpotifyResponse.sampleResponse.tracks[0],
                                                     viewModel: viewModel)
                }
                
            }
        }
        .navigationTitle("Liked Songs")
        .navigationBarTitleDisplayMode(.inline)
        .alert("User Not Found", isPresented: $viewModel.isShowingError) {
            Button("OK") {
                viewModel.isShowingError = false
            }
        } message: {
            Text("Please log back in.")
        }
        .onAppear {
            showTabView = false
            
            guard let user else {
                viewModel.isShowingError = true
                return
            }
            
            viewModel.loadSongs(user: user)
        }
        .onDisappear {
            showTabView = true
        }
    }
}


#Preview {
    SynchroSoundLikedSongs(showTabView: .constant(false))
        .modelContainer(for: User.self)
}
