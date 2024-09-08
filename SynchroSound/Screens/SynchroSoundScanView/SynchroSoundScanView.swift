//
//  SynchroSoundScanView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//


import SwiftUI

struct SynchroSoundScanView: View {
    
    @StateObject var viewModel = SynchroSoundScanViewModel()
    
    var body: some View {
        ZStack {
            SynchroSoundBackground()
            
            VStack {
                SynchroSoundTitle()
                
                Spacer()
                
                Text(viewModel.detectedEmotion)
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                Button {
                    viewModel.showCamera = true
                } label: {
                    SynchroSoundSymbolCircle(symbol: "camera.viewfinder", description: "")
                }
                .padding(.bottom, 60)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            CameraView(isPresented: $viewModel.showCamera, selectedImage: $viewModel.selectedImage)
                .ignoresSafeArea()
                .onDisappear {
                    if let image = viewModel.selectedImage {
                        viewModel.detectEmotion(from: image)
                        
                        if !viewModel.detectedEmotion.isEmpty {
                            viewModel.showEmotionResults = true
                        }
                    }
                }
        }
        .fullScreenCover(isPresented: $viewModel.showEmotionResults) {
            SynchroSoundSongsView(scanViewModel: viewModel)
        }
    }
}

#Preview {
    SynchroSoundScanView()
}
