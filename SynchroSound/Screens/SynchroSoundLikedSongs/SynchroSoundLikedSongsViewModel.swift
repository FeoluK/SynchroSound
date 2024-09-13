//
//  SynchroSoundLikedSongsViewModel.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/11/24.
//

import SwiftUI
import SwiftData
import AVFoundation

class SynchroSoundLikedSongsViewModel: ObservableObject {
    @Published var favoriteSongs: [SpotifyResponse.TrackObject] = []
    @Published var showingDetailView = false
    @Published var selectedTrack: SpotifyResponse.TrackObject?
    @Published var player: AVPlayer?
    @Published var isPlayingPreview = false
    @Published var currentTime: Double = 0.0
    @Published var isShowingAlert = false
    @Published var columns = [
           GridItem(.flexible(), spacing: 15),
           GridItem(.flexible(), spacing: 15)
       ]
    @Published var searchQuery: String = ""
    @Published var isShowingError = false
    
    var filteredSongs: [SpotifyResponse.TrackObject] {
            if searchQuery.isEmpty {
                return favoriteSongs
            } else {
                return favoriteSongs.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    
    private var timer: Timer?
    
    let previewDuration: Double = 30.0
    
    func loadSongs(user: User) {
        favoriteSongs = user.favoriteSongs
    }
    
    func getArtists(track: SpotifyResponse.TrackObject) -> String {
        return track.artists.map {$0.name}.joined(separator: ", ")
    }
    
    func configurePreview(previewURL: String) {
        guard let url = URL(string: previewURL) else {
            print("Invalid previewURL")
            return
        }
        
        player = AVPlayer(url: url)
        setupTimer()
    }
    
    func playPausePreview() {
        if(selectedTrack?.preview_url == nil) {
            isShowingAlert = true
        }
        
        guard let player = player else { return }
        
        if player.rate == 1.0 {
            player.pause()
            isPlayingPreview = false
            timer?.invalidate()
        } else {
            player.play()
            isPlayingPreview = true
            setupTimer()
        }
    }
    
    func seekTo(time: Double) {
        guard let player = player else { return }
        let seekTime = CMTime(seconds: time, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    private func setupTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.currentTime = self.player?.currentTime().seconds ?? 0.0
            if self.currentTime >= self.previewDuration {
                self.player?.pause()
                self.isPlayingPreview = false
                self.timer?.invalidate()
            }
        }
    }
    
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}
