//
//  SynchroSoundLikedSongsDetailView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/12/24.
//

import SwiftUI
import AVFoundation

struct SynchroSoundLikedSongsDetailView: View {
    let track: SpotifyResponse.TrackObject
    @ObservedObject var viewModel: SynchroSoundLikedSongsViewModel
    @EnvironmentObject var loginState: LoginState
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.brandBlue)
            
            VStack {
                
                SpotifySongImage(imageURL: track.album.images.first?.url ??
                                 MockSpotifyResponse.sampleResponse.tracks[0].album.images[0].url)
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(track.name)
                    .padding(.top, 1)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(width: 200, alignment: .leading)
                    .lineLimit(1)
                
                Text(viewModel.getArtists(track: track))
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(width: 200, alignment: .leading)
                    .lineLimit(1)
                    .padding(.bottom, 15)
                
                HStack {
                    Text(viewModel.formatTime(viewModel.currentTime))
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    
                    Slider(value: $viewModel.currentTime, in: 0...viewModel.previewDuration, onEditingChanged: { editing in
                        if !editing {
                            viewModel.seekTo(time: viewModel.currentTime)
                        }
                    })
                    .accentColor(.white)
                    
                    Text(viewModel.formatTime(viewModel.previewDuration))
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                }
                .padding(.horizontal, 20)
                
                HStack(spacing: 25) {
                    Button {
                        guard let currentUser = loginState.currentUser else { return }
                        
                        if let index = currentUser.favoriteSongs.firstIndex(where: { $0.id == track.id }) {
                            loginState.currentUser?.favoriteSongs.remove(at: index)
                        } else {
                            loginState.currentUser?.favoriteSongs.append(track)
                        }
                        
                    } label: {
                        Image(systemName: loginState.currentUser?.favoriteSongs.contains(where: { $0.id == track.id }) == true ?
                              "heart.fill" : "heart")
                            .font(.system(size: 30))
                            .tint(.white)
                    }
                    
                    Button {
                        viewModel.playPausePreview()
                    } label: {
                        if track.preview_url != nil {
                            Image(systemName: viewModel.isPlayingPreview ? "stop.circle.fill" : "play.circle.fill")
                                .font(.system(size: 60))
                                .tint(.white)
                        } else {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 60))
                                .tint(.white)
                        }
                    }
                    
                    Button {
                        viewModel.configurePreview(previewURL: track.preview_url ?? "No URL")
                        if (viewModel.isPlayingPreview) {
                            viewModel.playPausePreview()
                        }
                        
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 30))
                            .tint(.white)
                    }
                }
                            
                Link(destination: URL(string: "https://open.spotify.com/track/\(track.id)")!, label: {
                    Label("Spotify", systemImage: "arrow.up.right.square.fill")
                        .tint(.white)
                        .font(.system(size: 20))
                })
                .offset(CGSize(width: 0.0, height: 20.0))

            }
            
            VStack() {
                HStack {
                    Button {
                        viewModel.showingDetailView = false
                        viewModel.selectedTrack = nil
                        viewModel.isPlayingPreview = false
                        viewModel.configurePreview(previewURL: track.preview_url ?? "No URL")
                        viewModel.currentTime = 0.0
                        guard let currentUser = loginState.currentUser else { return }
                        viewModel.loadSongs(user: currentUser )
                    } label: {
                        XDismissButton()
                            .offset(CGSize(width: -7.0, height: -3.0))
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .frame(width: 300, height: 520)
        .onAppear() {
            viewModel.configurePreview(previewURL: track.preview_url ?? "No URL")
        }
        .alert("No Preview Available", isPresented: $viewModel.isShowingAlert) {
            Button("OK") {
                viewModel.isShowingAlert = false
            }
        } message: {
            Text("Please open song in spotify to play.")
        }

    }
}

#Preview {
    SynchroSoundSongsDetailView(track: MockSpotifyResponse.sampleResponse.tracks[0], viewModel: SynchroSongsViewModel())
}
