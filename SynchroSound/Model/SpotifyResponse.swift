//
//  SongData.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SpotifyResponse: Codable {
    
    struct Track: Codable {
        let href: String
        let next: String
        let previous: String
        let total: String
        let items: [Item]
    }
    
    struct Item: Codable {
        let album: [Album]
        let artists: [Artist]
        let duration_ms: Int
        let href: String
        let id: String
        let name: String
    }
    
    struct Album: Codable {
        let album_type: String
        let total_tracks: Int
        let href: String
        let id: String
        let images: [AlbumCover]
        let name: String
    }
    
    struct Artist: Codable {
        let href: String
        let id: String
        let name: String
    }
    
    struct AlbumCover: Codable {
        let url: String
        let height: Int
        let width: Int
    }
    
}
