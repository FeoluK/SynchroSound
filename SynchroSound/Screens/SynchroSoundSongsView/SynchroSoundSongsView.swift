//
//  SynchroSoundSongsView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SynchroSoundSongsView: View {
    
    @ObservedObject var scanViewModel: SynchroSoundScanViewModel
    @StateObject var songViewModel = SynchroSongsViewModel()

    var body: some View {
        ZStack {
            SynchroSoundSongBackground()
            
            VStack(spacing: 0) {
                
                SpotifySongImage(imageURL: songViewModel.tracks.first?.album.images.first?.url ??
                                 MockSpotifyResponse.sampleResponse.tracks[0].album.images[0].url)
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .foregroundStyle(.white)
                
                Text("Your Song Matches")
                    .font(.system(size: 35, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                
                Text("Songs based on your current mood")
                    .font(.system(size: 23, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 350, height: 5)
                    .foregroundStyle(.brandVibrantBlue)
                    .padding(.vertical, 15)
                
                Button {
                    songViewModel.isShowingMoodDetail.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.brandVibrantBlue)
                            .frame(width: 300, height: 40)
                        Text("View Mood")
                            .foregroundStyle(.white)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                    }
                    
                }
                                    
                SynchroSoundSongMatchesView(viewModel: songViewModel)
            }
            .blur(radius: songViewModel.showingDetailView ? 20 : 0)
            
            if !songViewModel.showingDetailView {
                VStack {
                    HStack {
                        Button {
                            scanViewModel.showEmotionResults = false
                        } label: {
                            XDismissButton()
                                .offset(CGSize(width: 0, height: -20.0))
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            } else {
                SynchroSoundSongsDetailView(track: songViewModel.selectedTrack ??
                                            MockSpotifyResponse.sampleResponse.tracks[0],
                                            viewModel: songViewModel)
            }
            
        }
        .onAppear {
            songViewModel.getSongs(spotifyRequest: scanViewModel.spotifyRequest ?? MockSpotifyRequest.sadRequest)
        }
        .sheet(isPresented: $songViewModel.isShowingMoodDetail) {
            let emotionValues = scanViewModel.getEmotionValues(with: ["Joy": "VERY_LIKELY", "Sadness": "UNLIKELY", "Anger": "POSSIBLE", "Surprise": "LIKELY"])
            let moods = emotionValues.map { MoodData(emotion: $0.key, value: $0.value) }
            SynchroSoundMoodDetailView(moods: moods)
        }
    }
}

#Preview {
    SynchroSoundSongsView(scanViewModel: SynchroSoundScanViewModel())
        .environmentObject(LoginState())
}
