//
//  SynchroSoundScanViewModel.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

class SynchroSoundScanViewModel: ObservableObject {
    @Published var showCamera = false
    @Published var selectedImage: UIImage?
    @Published var detectedEmotion: String = "No emotion detected yet"
    @Published var showEmotionResults = false
    
    func detectEmotion(from image: UIImage) {
        Task {
            do {
                let emotion = try await NetworkManager.shared.detectEmotion(from: image)
                DispatchQueue.main.async {
                    self.detectedEmotion = emotion
                }
            } catch {
                DispatchQueue.main.async {
                    self.detectedEmotion = "Error detecting emotion"
                }
            }
        }
    }
}
