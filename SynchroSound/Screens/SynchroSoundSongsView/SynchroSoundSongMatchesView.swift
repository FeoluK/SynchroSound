//
//  SynchroSoundSongMatchesView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/6/24.
//

import SwiftUI

struct SynchroSoundSongMatchesView: View {
    
    @ObservedObject var viewModel: SynchroSongsViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns, spacing: 10) {
                    ForEach(viewModel.tracks, id: \.self) { track in
                        SpotifySongCell(track: track)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 15)
            }
            .frame(maxHeight: 375)
        }
        .padding(.top, 15)
        .padding(.bottom, 40)
        .onAppear {
            viewModel.getSongs(spotifyRequest: MockSpotifyRequest.sadRequest)
        }
    }
}

#Preview {
    SynchroSoundSongMatchesView(viewModel: SynchroSongsViewModel())
}
