//
//  SynchroSoundSongsViewModel.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/6/24.
//

import SwiftUI

class SynchroSongsViewModel: ObservableObject {
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    @Published var tracks: [SpotifyResponse.TrackObject] = []
    
    func getSongs(spotifyRequest: SpotifyRequest) {
        Task {
            do {
                let requestTracks = try await NetworkManager.shared.getSongs(spotifyRequest: spotifyRequest).tracks
                DispatchQueue.main.async {
                    self.tracks = requestTracks
                }
                
            } catch {
                print("Error Occured in SongMatchesViewModel")
                DispatchQueue.main.async {
                    self.tracks = MockSpotifyResponse.sampleResponse.tracks
                }
            }
            
        }
    }
}

