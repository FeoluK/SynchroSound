//  SpotifyResponse.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SpotifyResponse: Codable, Hashable {
    let seeds: [RecommendationSeedObject]
    let tracks: [TrackObject]
    
    struct RecommendationSeedObject: Codable, Hashable {
        let afterFilteringSize: Int
        let href: String?  // Make this an optional
        let id: String
        let initialPoolSize: Int
        let type: String
    }
    
    struct TrackObject: Codable, Hashable {
        let album: Album
        let artists: [Artist]
        let duration_ms: Int
        let external_urls: ExternalURL
        let href: String
        let id: String
        let name: String
        let preview_url: String?
        let popularity: Int
        let type: String
    }
    
    struct Album: Codable, Hashable {
        let album_type: String
        let total_tracks: Int
        let available_markets: [String]
        let external_urls: ExternalURL
        let href: String
        let id: String
        let images: [ImageObject]
        let name: String
        let release_date: String
        let release_date_precision: String
        let type: String
        let uri: String
        let artists: [Artist]
    }
    
    struct ExternalURL: Codable, Hashable {
        let spotify: String
    }
    
    struct ImageObject: Codable, Hashable {
        let url: String
        let height: Int
        let width: Int
    }
    
    struct Artist: Codable, Hashable {
        let external_urls: ExternalURL
        let href: String
        let name: String
        let type: String
        let uri: String
    }
}

struct SpotifyGenreResponse: Codable, Hashable {
    let genres: [String]
}

struct MockSpotifyResponse {
    static let sampleResponse = SpotifyResponse(
        seeds: [
            SpotifyResponse.RecommendationSeedObject(
                afterFilteringSize: 10,
                href: "https://api.spotify.com/v1/recommendations?seed_genres=pop",
                id: "pop",
                initialPoolSize: 100,
                type: "genre"
            )
        ],
        tracks: [
            SpotifyResponse.TrackObject(
                album: SpotifyResponse.Album(
                    album_type: "single",
                    total_tracks: 1,
                    available_markets: [],
                    external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/album/1"),
                    href: "https://api.spotify.com/v1/albums/1",
                    id: "1",
                    images: [
                        SpotifyResponse.ImageObject(
                            url: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
                            height: 640,
                            width: 640
                        )
                    ],
                    name: "This is the first sample album name",
                    release_date: "2024-09-07",
                    release_date_precision: "day",
                    type: "album",
                    uri: "spotify:album:1",
                    artists: [
                        SpotifyResponse.Artist(
                            external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/1"),
                            href: "https://api.spotify.com/v1/artists/1",
                            name: "Sample Artist 1",
                            type: "artist",
                            uri: "spotify:artist:1"
                        )
                    ]
                ),
                artists: [
                    SpotifyResponse.Artist(
                        external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/1"),
                        href: "https://api.spotify.com/v1/artists/1",
                        name: "Sample Artist 1",
                        type: "artist",
                        uri: "spotify:artist:1"
                    ),
                    SpotifyResponse.Artist(
                        external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/1"),
                        href: "https://api.spotify.com/v1/artists/1",
                        name: "Sample Artist 2",
                        type: "artist",
                        uri: "spotify:artist:1"
                    )
                ],
                duration_ms: 180000,
                external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/track/1"),
                href: "https://api.spotify.com/v1/tracks/1",
                id: "1",
                name: "This is the sample track name 1",
                preview_url: nil,
                popularity: 80,
                type: "track"
            ),
            SpotifyResponse.TrackObject(
                album: SpotifyResponse.Album(
                    album_type: "single",
                    total_tracks: 1,
                    available_markets: [],
                    external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/album/2"),
                    href: "https://api.spotify.com/v1/albums/2",
                    id: "2",
                    images: [
                        SpotifyResponse.ImageObject(
                            url: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
                            height: 640,
                            width: 640
                        )
                    ],
                    name: "Sample Album 2",
                    release_date: "2024-09-08",
                    release_date_precision: "day",
                    type: "album",
                    uri: "spotify:album:2",
                    artists: [
                        SpotifyResponse.Artist(
                            external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/2"),
                            href: "https://api.spotify.com/v1/artists/2",
                            name: "Sample Artist 2",
                            type: "artist",
                            uri: "spotify:artist:2"
                        )
                    ]
                ),
                artists: [
                    SpotifyResponse.Artist(
                        external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/2"),
                        href: "https://api.spotify.com/v1/artists/2",
                        name: "Sample Artist 2",
                        type: "artist",
                        uri: "spotify:artist:2"
                    )
                ],
                duration_ms: 210000,
                external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/track/2"),
                href: "https://api.spotify.com/v1/tracks/2",
                id: "2",
                name: "Sample Track 2",
                preview_url: nil,
                popularity: 70,
                type: "track"
            ),
            SpotifyResponse.TrackObject(
                album: SpotifyResponse.Album(
                    album_type: "single",
                    total_tracks: 1,
                    available_markets: [],
                    external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/album/3"),
                    href: "https://api.spotify.com/v1/albums/3",
                    id: "3",
                    images: [
                        SpotifyResponse.ImageObject(
                            url: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
                            height: 640,
                            width: 640
                        )
                    ],
                    name: "Sample Album 3",
                    release_date: "2024-09-09",
                    release_date_precision: "day",
                    type: "album",
                    uri: "spotify:album:3",
                    artists: [
                        SpotifyResponse.Artist(
                            external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/3"),
                            href: "https://api.spotify.com/v1/artists/3",
                            name: "Sample Artist 3",
                            type: "artist",
                            uri: "spotify:artist:3"
                        )
                    ]
                ),
                artists: [
                    SpotifyResponse.Artist(
                        external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/3"),
                        href: "https://api.spotify.com/v1/artists/3",
                        name: "Sample Artist 3",
                        type: "artist",
                        uri: "spotify:artist:3"
                    )
                ],
                duration_ms: 240000,
                external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/track/3"),
                href: "https://api.spotify.com/v1/tracks/3",
                id: "3",
                name: "Sample Track 3",
                preview_url: nil,
                popularity: 90,
                type: "track"
            ),
            SpotifyResponse.TrackObject(
                album: SpotifyResponse.Album(
                    album_type: "single",
                    total_tracks: 1,
                    available_markets: [],
                    external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/album/4"),
                    href: "https://api.spotify.com/v1/albums/4",
                    id: "4",
                    images: [
                        SpotifyResponse.ImageObject(
                            url: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
                            height: 640,
                            width: 640
                        )
                    ],
                    name: "Sample Album 4",
                    release_date: "2024-09-10",
                    release_date_precision: "day",
                    type: "album",
                    uri: "spotify:album:4",
                    artists: [
                        SpotifyResponse.Artist(
                            external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/4"),
                            href: "https://api.spotify.com/v1/artists/4",
                            name: "Sample Artist 4",
                            type: "artist",
                            uri: "spotify:artist:4"
                        )
                    ]
                ),
                artists: [
                    SpotifyResponse.Artist(
                        external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/4"),
                        href: "https://api.spotify.com/v1/artists/4",
                        name: "Sample Artist 4",
                        type: "artist",
                        uri: "spotify:artist:4"
                    )
                ],
                duration_ms: 220000,
                external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/track/4"),
                href: "https://api.spotify.com/v1/tracks/4",
                id: "4",
                name: "Sample Track 4",
                preview_url: nil,
                popularity: 85,
                type: "track"
            ),
            SpotifyResponse.TrackObject(
                album: SpotifyResponse.Album(
                    album_type: "single",
                    total_tracks: 1,
                    available_markets: [],
                    external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/album/5"),
                    href: "https://api.spotify.com/v1/albums/5",
                    id: "5",
                    images: [
                        SpotifyResponse.ImageObject(
                            url: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
                            height: 640,
                            width: 640
                        )
                    ],
                    name: "Sample Album 5",
                    release_date: "2024-09-11",
                    release_date_precision: "day",
                    type: "album",
                    uri: "spotify:album:5",
                    artists: [
                        SpotifyResponse.Artist(
                            external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/5"),
                            href: "https://api.spotify.com/v1/artists/5",
                            name: "Sample Artist 5",
                            type: "artist",
                            uri: "spotify:artist:5"
                        )
                    ]
                ),
                artists: [
                    SpotifyResponse.Artist(
                        external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/artist/5"),
                        href: "https://api.spotify.com/v1/artists/5",
                        name: "Sample Artist 5",
                        type: "artist",
                        uri: "spotify:artist:5"
                    )
                ],
                duration_ms: 200000,
                external_urls: SpotifyResponse.ExternalURL(spotify: "https://open.spotify.com/track/5"),
                href: "https://api.spotify.com/v1/tracks/5",
                id: "5",
                name: "Sample Track 5",
                preview_url: nil,
                popularity: 75,
                type: "track"
            )
        ]
    )
}
