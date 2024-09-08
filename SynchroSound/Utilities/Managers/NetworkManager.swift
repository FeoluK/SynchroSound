//
//  NetworkManager.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/4/24.
//

import SwiftUI

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static private let googleAPIKEY = ""
    static private let googleURL = "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKEY)"
    static private let spotifyClientID = ""
    static private let spotifyClientSecret = ""
    static private var spotifyAccessToken = ""
    static private let spotifyURL = "https://api.spotify.com/v1/recommendations"
    
    
    private init() {}
    
    func detectEmotion(from image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return "Unable to convert image to JPEG."
        }
        
        let base64Image = imageData.base64EncodedString()
        
        guard let url = URL(string: NetworkManager.googleURL) else {
            return "Invalid URL."
        }
        
        let requestPayload: [String: Any] = [
            "requests": [
                [
                    "image": ["content": base64Image],
                    "features": [
                        ["type": "FACE_DETECTION", "maxResults": 1]
                    ]
                ]
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestPayload, options: []) else {
            return "Unable to serialize request payload."
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return "No HTTP URL response received."
        }
        
        guard httpResponse.statusCode == 200 else {
            return "HTTP response error \nCode: \(httpResponse.statusCode)"
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(GoogleCloudVisionResponse.self, from: data)
            
            guard let faceAnnotations = response.responses.first?.faceAnnotations.first else {
                return "No face annotations found."
            }
            
            return """
            Joy: \(faceAnnotations.joyLikelihood)
            Sorrow: \(faceAnnotations.sorrowLikelihood)
            Anger: \(faceAnnotations.angerLikelihood)
            Surprise: \(faceAnnotations.surpriseLikelihood)
            """
            
        } catch {
            return "Unable to decode data"
        }
    }
    
    func requestSpotifyAccessToken(clientID: String, clientSecret: String) async throws -> String {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyParams = [
            "grant_type": "client_credentials",
            "client_id": clientID,
            "client_secret": clientSecret
        ]
        
        let bodyString = bodyParams.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let errorMessage = "HTTP request failed with response: \(response)"
                print(errorMessage)
                throw URLError(.badServerResponse)
            }
            
            let decoder = JSONDecoder()
            let authResponse = try decoder.decode(SpotifyAuthResponse.self, from: data)
            
            return authResponse.access_token
            
        } catch {
            let errorMessage = "Failed to request access token: \(error)"
            print(errorMessage)
            throw error
        }
    }
    
    func getSongs(spotifyRequest: SpotifyRequest) async throws -> SpotifyResponse {
        var components = URLComponents(string: NetworkManager.spotifyURL)
        components?.queryItems = [
            URLQueryItem(name: "seed_genres", value: spotifyRequest.seed_genres),
            URLQueryItem(name: "target_danceability", value: "\(spotifyRequest.target_danceability)"),
            URLQueryItem(name: "target_energy", value: "\(spotifyRequest.target_energy)"),
            URLQueryItem(name: "target_liveness", value: "\(spotifyRequest.target_liveness)"),
            URLQueryItem(name: "target_tempo", value: "\(spotifyRequest.target_tempo)"),
            URLQueryItem(name: "target_valence", value: "\(spotifyRequest.target_valence)")
        ]
        
        guard let url = components?.url else {
            let errorMessage = "Failed to construct URL with components: \(String(describing: components))"
            print(errorMessage)
            throw URLError(.badURL)
        }
        
        do {
            NetworkManager.spotifyAccessToken = try await requestSpotifyAccessToken(clientID: NetworkManager.spotifyClientID, clientSecret: NetworkManager.spotifyClientSecret)
        } catch {
            print("Error fetching access token: \(error)")
            throw error
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(NetworkManager.spotifyAccessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let errorMessage = "Response is not of type HTTPURLResponse. Response: \(response)"
                print(errorMessage)
                throw URLError(.badServerResponse)
            }
            
            guard httpResponse.statusCode == 200 else {
                let errorMessage = "Received HTTP error code \(httpResponse.statusCode). Response: \(httpResponse)"
                print(errorMessage)
                throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
            }
            
            do {
                let decoder = JSONDecoder()
                let spotifyResponse = try decoder.decode(SpotifyResponse.self, from: data)
                return spotifyResponse
                
            } catch {
                let errorMessage = "Failed to decode SpotifyResponse. Data: \(String(data: data, encoding: .utf8) ?? "No data")"
                print(errorMessage)
                throw error
            }
            
        } catch {
            let errorMessage = "An error occurred while fetching data: \(error)"
            print(errorMessage)
            throw error
        }
    }
    
    
    
    
    func downloadImage(from imageURL: String) -> some View {
        return AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
            default:
                ProgressView()
                    .tint(.brandVibrantBlue)
                    .controlSize(.regular)
            }
            
        }
    }
}
