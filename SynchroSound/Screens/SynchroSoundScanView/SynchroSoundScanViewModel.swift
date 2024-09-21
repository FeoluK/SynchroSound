//
//  SynchroSoundScanViewModel.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

class SynchroSoundScanViewModel: ObservableObject {
    @Published var showCamera = false
    @Published var showPicker = false
    @Published var selectedImage: UIImage?
    @Published var showEmotionResults = false
    @Published var spotifyRequest: SpotifyRequest?    
    
    private func getScanResults(from image: UIImage) async throws -> [String : String] {
        do {
            let emotionResults = try await NetworkManager.shared.detectEmotion(from: image)
            return emotionResults
        } catch {
            throw error
        }
    }
    
    func getSpotifyRecomendations(user: User) async {
        do {
            let emotions = try await getScanResults(from: selectedImage ?? UIImage())
            let emotionValues = EmotionManager.shared.getEmotionValues(with: emotions)
            let processedRequest = EmotionManager.shared.processEmotionValues(with: emotionValues, for: user)
            
            DispatchQueue.main.async {
                self.showEmotionResults = true
                self.spotifyRequest = processedRequest
            }
            
        } catch {
            print("Failed to handle Spotify Recomendations")
        }
    }
    
    func getEmotionValues(with emotions: [String: String]) -> [String: Float] {
        return EmotionManager.shared.getEmotionValues(with: emotions)
    }
}
