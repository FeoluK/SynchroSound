//
//  SynchroSoundLikedSongsContent.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/12/24.
//

import SwiftUI

struct SynchroSoundLikedSongsContent: View {
    
    @ObservedObject var viewModel = SynchroSoundLikedSongsViewModel()
    
    var body: some View {
        VStack {
            TextField("Search by track name...", text: $viewModel.searchQuery)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: viewModel.columns, spacing: 10) {
                    ForEach(viewModel.filteredSongs, id: \.self) { track in
                        Button {
                            viewModel.selectedTrack = track
                            viewModel.showingDetailView = true
                        } label: {
                            SpotifySongCell(track: track)
                        }
                        .disabled(viewModel.showingDetailView)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 15)
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 40)
    }
}

#Preview {
    SynchroSoundLikedSongsContent(viewModel: SynchroSoundLikedSongsViewModel())
}
