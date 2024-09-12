//
//  SynchroSoundLikedSongsViewModel.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/11/24.
//

import SwiftUI
import SwiftData

class SynchroSoundLikedSongsViewModel: ObservableObject {
    @Published var favoriteSongs: [SpotifyResponse.TrackObject] = []
    
    func loadFavoriteSongs(user: User) {
        favoriteSongs = user.favoriteSongs
    }
}
