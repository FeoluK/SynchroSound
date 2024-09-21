//
//  SynchroSoundScanView.swift
//  SynchroSound
//
//  Created by Feolu Kolawole on 9/5/24.
//

import SwiftUI

struct SynchroSoundScanView: View {
    @StateObject var viewModel = SynchroSoundScanViewModel()
    @EnvironmentObject var loginState: LoginState
    @State private var showPhotoPicker = false
    @State private var isUsingCamera = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
                                       startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()

            VStack {
                SynchroSoundTitle()
                    .padding(.top, 50)

                Spacer()

                Text("Scan your face or choose a photo to match your mood with music")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)

                Spacer()

                VStack(spacing: 20) {
                    Button {
                        isUsingCamera = true
                        showPhotoPicker = true
                    } label: {
                        SynchroSoundSymbolCircle(symbol: "camera.viewfinder", description: "Scan Face")
                    }

                    Button {
                        isUsingCamera = false
                        showPhotoPicker = true
                    } label: {
                        SynchroSoundSymbolCircle(symbol: "photo.on.rectangle.angled", description: "Choose from Photos")
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .fullScreenCover(isPresented: $showPhotoPicker) {
            CameraView(isPresented: $showPhotoPicker, selectedImage: $viewModel.selectedImage, sourceType: isUsingCamera ? .camera : .photoLibrary)
                .ignoresSafeArea()
                .onDisappear {
                    if viewModel.selectedImage != nil {
                        Task {
                            await viewModel.getSpotifyRecomendations(user: loginState.currentUser ?? User(email: "default@placeholder.com", name: "Default User"))
                            if viewModel.spotifyRequest != nil {
                                viewModel.showEmotionResults = true
                            }
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
        .environmentObject(LoginState())
}
