//
//  SpotifyRequest.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/7/24.
//

import SwiftUI

struct SpotifyRequest: Codable, Hashable {
    let seed_genres: String
    let target_danceability: Float
    let target_energy: Float
    let target_liveness: Float
    let target_tempo: Int
    let target_valence: Float
}


struct MockSpotifyRequest {
    
    static let sadRequest = SpotifyRequest(seed_genres: "afrobeat,pop,r-n-b,romance,soul",
                                               target_danceability: 0.2,
                                               target_energy: 0.25,
                                               target_liveness: 0.3,
                                               target_tempo: 65,
                                               target_valence: 0.2)
    
    static let happyRequest = SpotifyRequest(seed_genres: "afrobeat,pop,r-n-b,romance,soul",
                                               target_danceability: 0.8,
                                               target_energy: 0.7,
                                               target_liveness: 0.7,
                                               target_tempo: 135,
                                               target_valence: 0.8)
    
}

struct SpotifyAuthResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}
