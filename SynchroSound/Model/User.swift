//
//  User.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/10/24.
//

import SwiftData

@Model
class User: Identifiable {
    @Attribute(.unique) var email: String
    var name: String
    var favoriteSongs: [SpotifyResponse.TrackObject] = []
    var preferedGenres: [String] = []

    init(email: String, name: String, favoriteSongs: [SpotifyResponse.TrackObject] = [], preferedGenres: [String] = []) {
        self.email = email
        self.name = name
        self.favoriteSongs = favoriteSongs
        self.preferedGenres = preferedGenres
    }
}

