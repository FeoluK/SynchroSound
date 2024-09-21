
//
//  EmotionManager.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/14/24.
//

import SwiftUI

class EmotionManager {
    
    static let shared = EmotionManager()
    
    private init() {}
    
    enum EmotionValues: String {
        case VERY_UNLIKELY = "VERY_UNLIKELY"
        case UNLIKELY = "UNLIKELY"
        case POSSIBLE = "POSSIBLE"
        case LIKELY = "LIKELY"
        case VERY_LIKELY = "VERY_LIKELY"
        
        var numericValue: Float {
            switch self {
            case .VERY_UNLIKELY: return 0.05
            case .UNLIKELY: return 0.25
            case .POSSIBLE: return 0.5
            case .LIKELY: return 0.75
            case .VERY_LIKELY: return 0.975
            }
        }
    }
    
    enum GenrePairs: String, CaseIterable {
        case Joy = "Joy"
        case Sadness = "Sadness"
        case Anger = "Anger"
        case Surprise = "Surprise"
        
        var genreMatches: [String] {
            switch self {
            case .Joy: return ["pop", "dance", "salsa", "happy", "afrobeat"]
            case .Sadness: return ["blues", "sad", "singer-songwriter", "piano"]
            case .Anger: return ["metal", "hardcore", "punk-rock", "grindcore", "industrial"]
            case .Surprise: return ["dubstep", "electro", "techno", "workout"]
            }
            
        }
    }
    
    func getEmotionValues(with emotions: [String : String]) -> [String : Float] {
        var processedEmotions: [String : Float] = [:]
        
        for (emotion, value) in emotions {
            if let emotionValue = EmotionValues(rawValue: value) {
                processedEmotions[emotion] = emotionValue.numericValue
            }
        }
        
        return processedEmotions
    }
    
    func processEmotionValues(with emotions: [String : Float], for user: User) -> SpotifyRequest {
        let joyValue = emotions["Joy"] ?? 0.5
        let target_valence = exponentialScale((joyValue * 0.9), lowerBound: 0.0, upperBound: 1.0)
        
        let angerValue = emotions["Anger"] ?? 0.5
        let target_energy = exponentialScale((angerValue * 0.8) + (joyValue * 0.2), lowerBound: 0.3, upperBound: 0.7)
        
        let target_danceability = exponentialScale(joyValue, lowerBound: 0.3, upperBound: 0.7)
        
        let supriseValue: Float = emotions["Surprise"] ?? 0.5
        let target_liveness = exponentialScale(supriseValue, lowerBound: 0.35, upperBound: 0.65)
        let target_tempo = Int(exponentialScale(emotions["Joy"] ?? 110, lowerBound: 40.0, upperBound: 180.0))
        
        
        let emotionValues: [String: Float] = [
            "Joy": emotions["Joy"] ?? 0.5,
            "Sadness": emotions["Sadness"] ?? 0.5,
            "Anger": emotions["Anger"] ?? 0.5,
            "Surprise": emotions["Surprise"] ?? 0.5
        ]
        
        let highestEmotion = emotionValues.max(by: { a, b in a.value < b.value })?.key ?? "Unknown"
        
        var seed_genres: String = ""
        
        if (user.preferedGenres.count > 0) {
            seed_genres = user.preferedGenres.joined(separator: ",")
        } else {
            for type in GenrePairs.allCases {
                if type.rawValue == highestEmotion {
                    seed_genres = type.genreMatches.joined(separator: ",")
                }
            }
        }
        
        print("Seed Genres: \(seed_genres)")
        print("Target Danceability: \(target_danceability)")
        print("Target Energy: \(target_energy)")
        print("Target Tempo: \(target_tempo)")
        print("Target Valence: \(target_valence)")
        
        return SpotifyRequest(
            seed_genres: seed_genres,
            target_danceability: target_danceability,
            target_energy: target_energy,
            target_liveness: target_liveness,
            target_tempo: target_tempo,
            target_valence: target_valence
        )
    }
    
    private func exponentialScale(_ num: Float, lowerBound: Float = 0.0, upperBound: Float = 1.0) -> Float {
        var scaleFactor: Float = 1.0
        
        if num >= 0.5 {
            scaleFactor = 0.8
        } else {
            scaleFactor = 1.2
        }
        
        let scaledNum = pow(num, scaleFactor)
        return lowerBound + (upperBound - lowerBound) * scaledNum
    }
}
