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
    
}
